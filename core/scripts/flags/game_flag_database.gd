@tool
class_name GameFlagDatabase
extends Resource

@export var game_flags: Array[GameFlag] = []

@export_group("Editor Settings", "editor_")
@export var editor_flags_directory: String

@export_tool_button("Update Database") var editor_update_callable = update_database


func update_database() -> void:
	game_flags = []
	
	var file_paths: Array[String] = FileUtils.get_all_file_paths(editor_flags_directory)
	for file_path in file_paths:
		var game_flag: Resource = ResourceLoader.load(file_path)
		if game_flag == null:
			continue
		
		game_flags.append(game_flag)
	
	ResourceSaver.save(self)
	
	print("Updated " + ResourceUtils.get_resource_name(self) + " Database")
