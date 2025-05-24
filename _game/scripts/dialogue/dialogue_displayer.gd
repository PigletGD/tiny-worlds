class_name DialogueDisplayer
extends Node

signal started_displaying()
signal finished_displaying()
signal finished_displaying_input()

@export var root: Control
@export var rich_text_label: RichTextLabel
@export var button_list: Array[DialogueButton]
@export var bool_check_timer: Timer

@export_group("Display Settings", "ds_")
@export var ds_ui_type: DialogueEnums.DialogueUI
@export var ds_type_writter_settings: DialogueTypeWritterSettings

@export_group("Global Signal Settings", "gs_")
@export var gs_finished_dialogue_sequence: GlobalSignal_DialogueLine

@onready var game_module_args: GameModuleArgs

var _current_dialogue: _DialogueLine
var _next_dialogue: _DialogueLine

var _text: String = ""
var _letter_index: int = 0

var _enable_mouse_input

var _current_time: float = 0.0

var _progression_dynamic_bool: _DynamicBool


func _ready() -> void:
	game_module_args = GameModuleArgs.new()
	game_module_args.initialize([self], self)
	
	_reset()


func _process(delta: float) -> void:
	_current_time -= delta
	
	if _current_time < 0.0:
		display_letter()


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MOUSE_BUTTON_LEFT:
		try_proceed_dialogue()


func _reset() -> void:
	rich_text_label.text = ""
	_letter_index = 0
	
	set_process_unhandled_input(false)


func display_text(dialogue_line: _DialogueLine) -> void:
	if not root.visible:
		root.visible = true
	
	_reset()
	
	_current_dialogue = dialogue_line
	_text = dialogue_line.line
	
	set_process(true)
	
	_current_dialogue.on_started(game_module_args)
	started_displaying.emit()


func display_letter() -> void:
	rich_text_label.text += _text[_letter_index]
	
	_letter_index += 1
	if _letter_index >= _text.length():
		_on_finished_displaying_text()
		finished_displaying.emit()
		set_process(false)
		return
	
	match _text[_letter_index]:
		"!", ".", ",", "?":
			_current_time += ds_type_writter_settings.punctuation_time
		" ":
			_current_time += ds_type_writter_settings.space_time
		_:
			_current_time += ds_type_writter_settings.letter_time
	
	if _current_time < 0.0:
		display_letter()


func _on_finished_displaying_text() -> void:
	_current_time = 0.0
	
	if _current_dialogue == null:
		return
	
	_current_dialogue.on_finished(game_module_args)
	
	if _current_dialogue is DialogueLine_Input:
		var input_dialogue := _current_dialogue as DialogueLine_Input
		_next_dialogue = input_dialogue.next_line
		set_process_unhandled_input(true)
		finished_displaying_input.emit()
	elif _current_dialogue is DialogueLine_Options:
		_setup_dialogue_buttons(_current_dialogue)
	elif _current_dialogue is DialogueLine_WaitForBool:
		_setup_bool_check_progression(_current_dialogue)


func _setup_dialogue_buttons(dialogue_line: DialogueLine_Options) -> void:
	for index in dialogue_line.dialogue_options.size():
		if index >= button_list.size():
			print("Not enough buttons in list to populate options.")
			return
		
		var button: DialogueButton = button_list[index]
		button.set_dialogue_option(dialogue_line.dialogue_options[index])
		button.visible = true


func _setup_bool_check_progression(dialogue_line: DialogueLine_WaitForBool) -> void:
	_progression_dynamic_bool = dialogue_line.boolean_evaluator
	_next_dialogue = dialogue_line.next_line
	bool_check_timer.start()


func hide_all_buttons() -> void:
	for button in button_list:
		button.visible = false


func on_selected_option(selected_option: DialogueOption) -> void:
	_next_dialogue = selected_option.dialogue_line
	try_proceed_dialogue()


func try_proceed_if_bool_is_true() -> void:
	if _progression_dynamic_bool == null:
		return
	
	if _progression_dynamic_bool.get_value(self):
		try_proceed_dialogue()
		bool_check_timer.stop()


func try_proceed_dialogue() -> void:
	hide_all_buttons()
	
	if _next_dialogue == null:
		root.visible = false
		return
	
	_current_dialogue.on_exited(game_module_args)
	
	if _next_dialogue.dialogue_ui != ds_ui_type:
		root.visible = false
	
	gs_finished_dialogue_sequence.emit(_next_dialogue)
