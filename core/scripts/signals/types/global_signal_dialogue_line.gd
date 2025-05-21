class_name GlobalSignal_DialogueLine
extends _GlobalSignal

signal signal_emitted(value: _DialogueLine)


func emit(value: _DialogueLine) -> void:
	signal_emitted.emit(value)


func subscribe(object: Object, method: String) -> void:
	signal_emitted.connect(Callable(object, method))
