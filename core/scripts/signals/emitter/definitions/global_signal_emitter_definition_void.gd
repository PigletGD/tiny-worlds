class_name GlobalSignalEmitterDefinition_Void
extends _GlobalSignalEmitterDefinition

@export var global_signal: GlobalSignal_Void


func emit(target: Object) -> void:
	global_signal.emit()
