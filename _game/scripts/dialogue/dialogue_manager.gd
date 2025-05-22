class_name DialogueManager
extends Node

@export var dialogue_ui_list: Array[DialogueUIReference]

var ui_dictionary: Dictionary


func _ready() -> void:
	print("HI")
	for dialogue_ui in dialogue_ui_list:
		if ui_dictionary.has(dialogue_ui.type):
			continue
		
		ui_dictionary[dialogue_ui.type] = get_node(dialogue_ui.node_path)


func run_dialogue_sequence(dialogue_line: _DialogueLine) -> void:
	if not ui_dictionary.has(dialogue_line.dialogue_ui):
		return
	
	var dialogue_diplayer := ui_dictionary[dialogue_line.dialogue_ui] as DialogueDisplayer
	if dialogue_diplayer == null:
		return
	
	dialogue_diplayer.display_text(dialogue_line)
