class_name FileCreationTester
extends Node

@export var test_rich_text_label: RichTextLabel
@export var test_sprite_2d: Sprite2D

@onready var abs_directory_path: String = OS.get_system_dir(OS.SystemDir.SYSTEM_DIR_DESKTOP) + "/TinyWorld/MyHouse"
@onready var local_file_path: String = abs_directory_path + "/Me.char"

var test_step: int = 0


func _ready() -> void:
	if !exists():
		create()
	
	test_rich_text_label.text = "HELLO! CAN YOU PLEASE NAME ME?"


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		if test_step == 0:
			check_for_changes_to_name()
		else:
			check_for_changes_to_color()


func exists() -> bool:
	if not DirAccess.dir_exists_absolute(abs_directory_path):
		DirAccess.make_dir_recursive_absolute(abs_directory_path)
	
	return FileAccess.file_exists(local_file_path)


func create() -> void:
	var character = FileAccess.open(local_file_path, FileAccess.WRITE)
	if character == null:
		print("An error occured while trying to write.")
		return
	
	character.store_line("Thank you for bringing me into this world!")
	character.store_line("May you please give me a name?")
	character.close()


func check_for_changes_to_name() -> void:
	var file_paths: Array[String] = []
	var dir: DirAccess = DirAccess.open(abs_directory_path)
	
	var characters_found: int = 0
	var first_name: String
	var first_file: String
	var still_unnamed: bool = false
	
	var files = dir.get_files()
	for file in files:
		var file_name_split: PackedStringArray = file.split(".")
		var extension: String = file_name_split[file_name_split.size() - 1]
		
		if extension != "char":
			continue
		
		var character_name: String = file_name_split[0]
		if character_name == "Me":
			still_unnamed = true
			continue
		
		if first_file == "":
			first_name = file_name_split[0]
			first_file = abs_directory_path + "/" + file
		characters_found += 1
	
	if still_unnamed:
		if characters_found == 0:
			test_rich_text_label.text = "ERMMMMM, I STILL HAVEN'T BEEN NAMED YET..."
		elif characters_found == 1:
			test_rich_text_label.text = "OH... I LOVE FRIENDS... BUT I ALSO LIKE NAMES..."
	else:
		if characters_found == 0:
			test_rich_text_label.text = "AHHHHHH! I'VE BEEN OBLIVIATED"
		elif characters_found == 1:
			test_rich_text_label.text = "WOW! " + first_name + " HUH? I LIKE IT?\nNEXT CAN YOU GIVE ME SOMETHING NEW TO WEAR?"
			add_color_to_character_file(first_file)
		else:
			test_rich_text_label.text = "OH... " + first_name + " HUH?\nTHAT'S COOL... BUT...\nTHERE'S PEOPLE IN MY HOUSE NOW..."


func add_color_to_character_file(character_file: String) -> void:
	var character = FileAccess.open(character_file, FileAccess.WRITE)
	if character == null:
		print("An error occured while trying to write.")
		return
	
	character.store_line("COLOR:")
	character.store_line("0.0")
	character.store_line("0.0")
	character.store_line("1.0")
	character.close()
	
	test_step += 1


func check_for_changes_to_color() -> void:
	var file_paths: Array[String] = []
	var dir: DirAccess = DirAccess.open(abs_directory_path)
	
	var files = dir.get_files()
	for file in files:
		var file_name_split: PackedStringArray = file.split(".")
		var extension: String = file_name_split[file_name_split.size() - 1]
		
		if extension != "char":
			continue
		
		var character = FileAccess.open(abs_directory_path + "/" + file, FileAccess.READ)
		if character == null:
			print("An error occured while trying to read.")
			return
		
		var line = character.get_line()
		while line != "":
			if line != "COLOR:":
				line = character.get_line()
				continue
			
			var hue_value: float = str_to_var(character.get_line())
			if hue_value != null:
				test_sprite_2d.material.set("shader_parameter/hue", hue_value)
			
			var brightness_line = character.get_line()
			var brightness_value: float = str_to_var(brightness_line)
			if brightness_value != null:
				test_sprite_2d.material.set("shader_parameter/brightness", brightness_value)
			
			var saturation_line: String = character.get_line()
			var saturation_value: float = str_to_var(saturation_line)
			if saturation_value != null:
				test_sprite_2d.material.set("shader_parameter/saturation", saturation_value)
			
			break
		
		character.close()
		
		break
