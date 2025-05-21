class_name DynamicBool_GameFlag
extends _DynamicBool

@export var game_flag: GameFlag


func get_value(target: Object) -> bool:
	return game_flag.is_enabled()
