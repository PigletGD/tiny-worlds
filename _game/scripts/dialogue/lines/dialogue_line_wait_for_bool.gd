class_name DialogueLine_WaitForBool
extends _DialogueLine

@export var next_line: _DialogueLine
@export var boolean_evaluator: _DynamicBool


func can_proceed(target: Object) -> bool:
	return boolean_evaluator.get_value(target)
