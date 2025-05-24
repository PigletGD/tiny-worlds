class_name WorldInitializer
extends Node

@export var global_signal_emitter: GlobalSignalEmitter


func _ready() -> void:
	global_signal_emitter.emit(null)


func create_world_folder() -> void:
	if not DirAccess.dir_exists_absolute(GlobalStrings.world_directory_path):
		DirAccess.make_dir_recursive_absolute(GlobalStrings.world_directory_path)
