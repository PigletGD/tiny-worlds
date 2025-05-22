class_name WorldInitializer
extends Node

@export var global_signal_emitter: GlobalSignalEmitter


func _ready() -> void:
	global_signal_emitter.emit()
