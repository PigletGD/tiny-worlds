class_name DynamicBool_Logical
extends _DynamicBool

@export var logical_operation: _LogicalOperation


func get_value(target: Object) -> bool:
	return logical_operation.evaluate(target)
