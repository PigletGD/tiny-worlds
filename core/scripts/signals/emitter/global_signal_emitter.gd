class_name GlobalSignalEmitter
extends Node

@export var global_signal_emitter_definitions: Array[_GlobalSignalEmitterDefinition]


func emit(target: Object) -> void:
	for definition in global_signal_emitter_definitions:
		definition.emit(target)
