class_name GameModule_SelectByBool
extends _GameModule

@export var game_module_evaluation_definition: Array[SelectModuleByBoolEvaluationDefinition]
@export var game_module_default: _GameModule


func invoke(args: GameModuleArgs) -> void:
	for definition in game_module_evaluation_definition:
		if definition.dynamic_bool.get_value(args.targets[0]):
			definition.game_module.invoke(args)
			return
	
	if game_module_default != null:
		game_module_default.invoke(args)
