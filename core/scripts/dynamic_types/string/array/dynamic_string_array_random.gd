class_name DynamicStringArray_Random
extends _DynamicStringArray

@export var values: Array[_DynamicStringArray]


func get_value(target: Object) -> Array[String]:
	var rng := RandomNumberGenerator.new()
	var index: int = rng.randi() % values.size()
	
	return values[index].get_value(target)
