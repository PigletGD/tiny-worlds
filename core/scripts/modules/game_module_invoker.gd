class_name GameModuleInvoker
extends Node

@export var game_module: _GameModule

var _args: GameModuleArgs


func _ready() -> void:
	_args = GameModuleArgs.new()
	_args.initialize([owner], self)


func invoke() -> void:
	game_module.invoke(_args)
