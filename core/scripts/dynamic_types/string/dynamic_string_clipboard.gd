class_name DynamicString_Clipboard
extends _DynamicString

enum TargetResult {
	RAW,
	RAW_NO_IMAGE,
	PATH
}

@export var default: _DynamicString
@export var target_result: TargetResult

@export var prevent_copy_if_image: bool = true


func get_value(target: Object) -> String:
	if DisplayServer.clipboard_has_image() and target_result != TargetResult.RAW:
		return _get_failed_string(target)
	
	var clipboard_text = DisplayServer.clipboard_get()
	if target_result != TargetResult.PATH:
		return clipboard_text
	
	var clipboard_path: String = clipboard_text.replace("\\", "/")
	clipboard_path = clipboard_path.replace("\"", "")
	return clipboard_path


func _get_failed_string(target: Object) -> String:
	if default == null:
		return ""
	
	return default.get_value(target)
