class_name DynamicDialogueLine_SelectByBool
extends _DynamicDialogueLine

@export var value_if_true: _DynamicDialogueLine
@export var value_if_false: _DynamicDialogueLine
@export var dynamic_bool: _DynamicBool


func get_value(target: Object) -> _DialogueLine:
	if dynamic_bool.get_value(target):
		return value_if_true.get_value(target)
	
	return value_if_false.get_value(target)
