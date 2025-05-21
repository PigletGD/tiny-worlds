class_name GlobalSignalReceiver
extends Node

@export var global_signal_receiver_definitions: Array[GlobalSignalReceiverDefinition]

func _ready():
	for definition in global_signal_receiver_definitions:
		for callable in definition.callables:
			var node = get_node(callable.node_path)
			
			if node == null:
				print("Could not find node")
				continue
			
			for method in callable.methods:
				if not node.has_method(method):
					print("Could not find method: " + method)
					continue
				
				definition.global_signal.subscribe(node, method)
