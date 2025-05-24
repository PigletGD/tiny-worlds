class_name LogicalOperation_XOR
extends _LogicalOperation

@export var dynamic_bool_one: _DynamicBool
@export var dynamic_bool_two: _DynamicBool


func evaluate(target: Object) -> bool:
	return dynamic_bool_one.get_value(target) != dynamic_bool_two.get_value(target)
