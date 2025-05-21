class_name GlobalSignal_Void
extends _GlobalSignal

signal signal_emitted()


func emit() -> void:
	signal_emitted.emit()


func subscribe(object: Object, method: String) -> void:
	signal_emitted.connect(Callable(object, method))
