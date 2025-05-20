class_name GameFlag
extends Resource

var value: bool


func enable_flag() -> void:
	value = true


func disable_flag() -> void:
	value = false


func reset() -> void:
	value = false


func is_enabled() -> bool:
	return value


func set_flag_to(new_value: bool) -> void:
	value = new_value
