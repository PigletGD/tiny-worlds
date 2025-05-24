class_name GameModule_SetGlobalString
extends _GameModule

@export var id: GlobalStrings.ID
@export var dynamic_string: _DynamicString


func invoke(args: GameModuleArgs) -> void:
	GlobalStrings.set_global_string(id, dynamic_string.get_value(self))
