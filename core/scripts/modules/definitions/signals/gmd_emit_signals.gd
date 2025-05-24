class_name GameModule_EmitSignal
extends _GameModule

@export var global_signal_emit_definition: _GlobalSignalEmitterDefinition


func invoke(args: GameModuleArgs) -> void:
	global_signal_emit_definition.emit(args.targets[0])
