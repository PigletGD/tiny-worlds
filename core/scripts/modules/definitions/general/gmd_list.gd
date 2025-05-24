class_name GameModule_List
extends _GameModule

@export var game_modules: Array[_GameModule] = []


func invoke(args: GameModuleArgs) -> void:
	for game_module in game_modules:
		game_module.invoke(args)
