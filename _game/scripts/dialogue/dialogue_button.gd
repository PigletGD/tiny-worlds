class_name DialogueButton
extends Button

@export var dialogue_displayer: DialogueDisplayer
@export var rich_text_label: RichTextLabel

var _dialogue_option: DialogueOption


func _ready() -> void:
	visible = false


func set_dialogue_option(option: DialogueOption) -> void:
	rich_text_label.text = option.option_line
	_dialogue_option = option


func on_pressed() -> void:
	dialogue_displayer.on_selected_option(_dialogue_option)
