class_name LogicalOperation_NOT
extends _LogicalOperation

@export var dynamic_bool: _DynamicBool


func evaluate(target: Object) -> bool:
	return !dynamic_bool.get_value(target)
