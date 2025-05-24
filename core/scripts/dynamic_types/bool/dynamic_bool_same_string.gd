class_name DynamicBool_SameString
extends _DynamicBool

@export var dynamic_string_one: _DynamicString
@export var dynamic_string_two: _DynamicString


func get_value(target: Object) -> bool:
	return dynamic_string_one.get_value(target) == dynamic_string_two.get_value(target)
