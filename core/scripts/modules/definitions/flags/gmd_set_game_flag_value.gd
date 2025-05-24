class_name GameModule_SetGameFlagValue
extends _GameModule

@export var game_flag: GameFlag
@export var value: _DynamicBool


func invoke(args: GameModuleArgs) -> void:
	if value.get_value(args.targets[0]):
		game_flag.enable_flag()
	else:
		game_flag.disable_flag()
