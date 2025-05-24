class_name DynamicStringArray_Static
extends _DynamicStringArray

@export var value: Array[_DynamicString]


func get_value(target: Object) -> Array[String]:
	var array: Array[String] = []
	for dynamic_string in value:
		var string = dynamic_string.get_value(target)
		if string == "":
			continue
		
		array.append(string)
	
	return array
