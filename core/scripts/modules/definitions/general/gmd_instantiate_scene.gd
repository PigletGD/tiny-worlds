class_name GameModule_InstantiateScene
extends _GameModule

@export var instantiate_definitions: Array[InstantiateDefinition]


func invoke(args: GameModuleArgs) -> void:
	var instigator_node = args.instigator as Node
	if instigator_node == null:
		return
	
	for definition in instantiate_definitions:
		var parent = instigator_node.get_node(definition.parent_path)
		if parent == null:
			continue
		
		for scene in definition.scenes_to_spawn:
			parent.add_child(scene.instantiate())
