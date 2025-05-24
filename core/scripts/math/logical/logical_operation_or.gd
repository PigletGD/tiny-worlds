class_name LogicalOperation_OR
extends _LogicalOperation

@export var dynamic_bools: Array[_DynamicBool]


func evaluate(target: Object) -> bool:
	for dynamic_bool in dynamic_bools:
		if dynamic_bool.get_value(target):
			return true
	
	return false
