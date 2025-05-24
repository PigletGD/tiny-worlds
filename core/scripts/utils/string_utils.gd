class_name StringUtils


#static func get_clipboard_string() -> String:
	#if DisplayServer.clipboard_has_image():
	#	return ""
	
	#_current_inspected_path = DisplayServer.clipboard_get()
	#var path_to_evaluate: String = _current_inspected_path.replace("\\", "/")

static func get_resource_name(resource: Resource) -> String:
	return resource.resource_path.get_file().trim_suffix(".tres")
