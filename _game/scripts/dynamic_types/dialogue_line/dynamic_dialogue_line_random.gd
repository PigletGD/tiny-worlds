class_name DynamicDialogueLine_Random
extends _DynamicDialogueLine

@export var values: Array[_DynamicDialogueLine]


func get_value(target: Object) -> _DialogueLine:
	var rng := RandomNumberGenerator.new()
	var index: int = rng.randi() % values.size()
	
	return values[index].get_value(target)
