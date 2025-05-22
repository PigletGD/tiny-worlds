class_name GlobalSignalEmitterDefinition_DialogueLine
extends _GlobalSignalEmitterDefinition

@export var global_signal: GlobalSignal_DialogueLine
@export var dialogue_line: _DialogueLine


func emit() -> void:
	global_signal.emit(dialogue_line)
