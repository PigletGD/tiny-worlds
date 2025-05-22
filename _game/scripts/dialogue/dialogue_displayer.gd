class_name DialogueDisplayer
extends Node

signal finished_displaying()

@export var rich_text_label: RichTextLabel
@export var timer: Timer

@export_group("Display Settings", "ds_")
@export var ds_type_writter_settings: DialogueTypeWritterSettings

var text = ""
var letter_index = 0


func display_text(dialogue_line: _DialogueLine) -> void:
	text = dialogue_line.line
	rich_text_label.text = ""
	
	display_letter()


func display_letter() -> void:
	rich_text_label.text += text[letter_index]
	
	letter_index += 1
	if letter_index >= text.length():
		finished_displaying.emit()
		return
	
	match text[letter_index]:
		"!", ".", ",", "?":
			timer.start(ds_type_writter_settings.punctuation_time)
		" ":
			timer.start(ds_type_writter_settings.space_time)
		_:
			timer.start(ds_type_writter_settings.letter_time)
