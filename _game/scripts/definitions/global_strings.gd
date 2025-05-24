extends Node

enum ID {
	WORLD_DIRECTORY_PATH,
	HOUSE_DIRECTORY_PATH,
	CHARACTER_FILE_PATH,
	ROOM_FILE_PATH,
	PREVIOUS_VALID_CLIPBOARD_PATH,
}

@onready var world_directory_path: String = OS.get_system_dir(OS.SystemDir.SYSTEM_DIR_DESKTOP) + "/TinyWorld"
@onready var house_directory_path: String = world_directory_path + "/MyHouse"
@onready var character_file_path: String = house_directory_path + "/Me.char"
@onready var room_file_path: String = house_directory_path + "/MainRoom.layout"

var previous_valid_clipboard_path: String


func get_global_string(id: ID) -> String:
	match id:
		ID.WORLD_DIRECTORY_PATH:
			return world_directory_path
		ID.HOUSE_DIRECTORY_PATH:
			return house_directory_path
		ID.CHARACTER_FILE_PATH:
			return character_file_path
		ID.ROOM_FILE_PATH:
			return room_file_path
		ID.PREVIOUS_VALID_CLIPBOARD_PATH:
			return previous_valid_clipboard_path
	
	return ""


func set_global_string(id: ID, string: String) -> void:
	match id:
		ID.WORLD_DIRECTORY_PATH:
			world_directory_path = string
		ID.HOUSE_DIRECTORY_PATH:
			house_directory_path = string
		ID.CHARACTER_FILE_PATH:
			character_file_path = string
		ID.ROOM_FILE_PATH:
			room_file_path = string
		ID.PREVIOUS_VALID_CLIPBOARD_PATH:
			previous_valid_clipboard_path = string
