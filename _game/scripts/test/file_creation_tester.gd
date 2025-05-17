class_name FileCreationTester
extends Node

@export var test_rich_text_lable: RichTextLabel

@onready var abs_directory_path: String = OS.get_system_dir(OS.SystemDir.SYSTEM_DIR_DESKTOP) + "/TinyWorld/MyHouse"
@onready var local_file_path: String = abs_directory_path + "/Me.char"


func _ready() -> void:
	if !exists():
		create()


func exists():
	if not DirAccess.dir_exists_absolute(abs_directory_path):
		DirAccess.make_dir_recursive_absolute(abs_directory_path)
	
	return FileAccess.file_exists(local_file_path)


func create():
	var character = FileAccess.open(local_file_path, FileAccess.WRITE)
	if character == null:
		print("An error occured while trying to save.")
		return
	
	
	character.store_line("Thank you for bringing me into this world!")
	character.store_line("May you please give me a name?")
	character.close()
