class_name FileCreationTester
extends Node

@export var test_rich_text_label: RichTextLabel
@export var test_sprite_2d: Sprite2D
@export var test_character: Node2D

@export var test_floor_panel: PackedScene
@export var test_floor_panel_parent: Node2D
@export var test_spawn_offset: Vector2

@export var test_images_array: Array[CompressedTexture2D]

@onready var abs_directory_path: String = OS.get_system_dir(OS.SystemDir.SYSTEM_DIR_DESKTOP) + "/TinyWorld/MyHouse"
@onready var local_character_file_path: String = abs_directory_path + "/Me.char"
@onready var local_room_file_path: String = abs_directory_path + "/MainRoom.layout"

var test_step: int = 5

var current_inspected_path


func _ready() -> void:
	if !exists(local_character_file_path):
		create_character()
	
	test_rich_text_label.text = "OPEN THE PACKAGE"
	#test_character.visible = false
	
	#create_room()
	
	DisplayServer.clipboard_set(abs_directory_path)
	
	if not DirAccess.dir_exists_absolute(abs_directory_path + "/test"):
		DirAccess.make_dir_recursive_absolute(abs_directory_path + "/test")


func _notification(what: int) -> void:
	if what == NOTIFICATION_APPLICATION_FOCUS_IN:
		if test_step == 0:
			check_for_changes_to_name()
		elif test_step == 1:
			check_for_changes_to_color()
		elif test_step == 2:
			room_spawn_test()
		elif test_step == 4:
			test_give_sprite()
		elif test_step == 5:
			test_create_zip()


func _process(delta: float) -> void:
	if test_step != 3:
		return
	
	if DisplayServer.clipboard_has_image():
		return
	
	if DisplayServer.clipboard_get() == current_inspected_path:
		return
	
	current_inspected_path = DisplayServer.clipboard_get()
	var path_to_evaluate: String = current_inspected_path.replace("\\", "/")
	print(path_to_evaluate)
	print(abs_directory_path)
	if path_to_evaluate == abs_directory_path:
		test_rich_text_label.text = "IM INSIDE THE HOUSE"
	elif path_to_evaluate == abs_directory_path + "/test":
		test_rich_text_label.text = "IM LOOKING AT MY TEST FOLDER"


func exists(path: String) -> bool:
	if not DirAccess.dir_exists_absolute(abs_directory_path):
		DirAccess.make_dir_recursive_absolute(abs_directory_path)
	
	return FileAccess.file_exists(path)


func create_character() -> void:
	var character = FileAccess.open(local_character_file_path, FileAccess.WRITE)
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


func create_room() -> void:
	if not exists(local_room_file_path):
		print("Just doing a precautionary create of the directory")
	
	var room = FileAccess.open(local_room_file_path, FileAccess.WRITE)
	if room == null:
		print("An error occured while trying to write.")
		return
	
	room.store_line("########")
	room.store_line("########")
	room.store_line("########")
	room.store_line("########")
	room.close()
	
	for x in 8:
		for y in 4:
			var tile_instance = test_floor_panel.instantiate() as Control
			test_floor_panel_parent.add_child(tile_instance)
			tile_instance.position = Vector2(x * test_spawn_offset.x, y * test_spawn_offset.y)


func room_spawn_test() -> void:
	var children = test_floor_panel_parent.get_children()
	for child in children:
		child.queue_free()
	
	var file_paths: Array[String] = []
	var dir: DirAccess = DirAccess.open(abs_directory_path)
	
	var files = dir.get_files()
	for file in files:
		var file_name_split: PackedStringArray = file.split(".")
		var extension: String = file_name_split[file_name_split.size() - 1]
		
		if extension != "layout":
			continue
		
		var room = FileAccess.open(abs_directory_path + "/" + file, FileAccess.READ)
		if room == null:
			print("An error occured while trying to read.")
			return
		
		var line = room.get_line()
		var y = 0
		while line != "":			
			for x in line.length():
				if line[x] == "#":
					var tile_instance = test_floor_panel.instantiate() as Control
					test_floor_panel_parent.add_child(tile_instance)
					tile_instance.position = Vector2(x * test_spawn_offset.x, y * test_spawn_offset.y)
			
			y += 1
			
			line = room.get_line()
		
		room.close()
		
		break


func test_check_for_folder_open() -> void:
	var test_path: String = abs_directory_path + "/test"
	var test_path_new: String = abs_directory_path + "/test1"
	var error: Error = DirAccess.rename_absolute(test_path, test_path_new)
	if error == Error.OK:
		print("Path is not open")
	else:
		print("Path is open.\n" + str(error))
	pass


func test_give_sprite() -> void:
	var image: Image = test_sprite_2d.texture.get_image()
	
	if not DirAccess.dir_exists_absolute(abs_directory_path + "/wardrobe"):
		DirAccess.make_dir_recursive_absolute(abs_directory_path + "/wardrobe")
	
	image.save_png(abs_directory_path + "/wardrobe/shirt.png")


func test_create_zip() -> void:
	if FileAccess.file_exists(abs_directory_path + "/package.zip"):
		print("Package already exists")
		return
	
	
	var writer = ZIPPacker.new()
	var err = writer.open(abs_directory_path + "/package.zip")
	if err != OK:
		print(str(err))
		return
	
	var index: int = 1
	for test_image in test_images_array:
		var image: Image = test_image.get_image()
		writer.start_file("plant_" + str(index) + ".png")
		writer.write_file(image.save_png_to_buffer())
		writer.close_file()
		index += 1

	writer.close()
	
	return
