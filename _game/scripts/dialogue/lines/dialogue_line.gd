class_name _DialogueLine
extends Resource

@export_multiline var line: String
@export var dialogue_ui: DialogueEnums.DialogueUI

@export_group("Game Modules", "_gm_")
@export var _gm_on_started_dialogue: _GameModule
@export var _gm_on_finished_dialogue: _GameModule
@export var _gm_on_exited_dialogue: _GameModule


func on_started(args: GameModuleArgs) -> void:
	if _gm_on_started_dialogue != null:
		_gm_on_started_dialogue.invoke(args)


func on_finished(args: GameModuleArgs) -> void:
	if _gm_on_finished_dialogue != null:
		_gm_on_finished_dialogue.invoke(args)


func on_exited(args: GameModuleArgs) -> void:
	if _gm_on_exited_dialogue != null:
		_gm_on_exited_dialogue.invoke(args)
