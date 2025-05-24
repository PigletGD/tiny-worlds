class_name ClipboardTracker
extends Node

@export var dynamic_string_array: _DynamicStringArray
@export var game_module: _GameModule

var _current_inspected_path: String

var _game_module_args: GameModuleArgs


func _ready() -> void:
	_game_module_args = GameModuleArgs.new()
	_game_module_args.initialize([self], self)


func check_for_clipboard_change() -> void:
	if DisplayServer.clipboard_has_image():
		return
	
	if DisplayServer.clipboard_get() == _current_inspected_path:
		return
	
	_current_inspected_path = DisplayServer.clipboard_get()
	var path_to_evaluate: String = _current_inspected_path.replace("\\", "/")
	
	var paths_to_analyze: Array[String] = dynamic_string_array.get_value(self)
	for path_to_analyze in paths_to_analyze:
		if path_to_evaluate == path_to_analyze:
			pass
