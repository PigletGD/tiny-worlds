class_name DynamicString_Globals
extends _DynamicString

@export var id: GlobalStrings.ID


func get_value(target: Object) -> String:
	return GlobalStrings.get_global_string(id)
