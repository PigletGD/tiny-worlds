class_name DynamicStringArray_SelectByBool
extends _DynamicStringArray

@export var definitions: Array[SelectDynamicStringArrayByBoolEvaluationDefinition]
@export var default: _DynamicStringArray


func get_value(target: Object) -> Array[String]:
	for definition in definitions:
		if definition.dynamic_bool.get_value(target):
			return definition.dynamic_string_array.get_value(target)
	
	if default == null:
		return []
	
	return default.get_value(target)
