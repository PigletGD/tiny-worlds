class_name FileUtils


static func get_all_file_paths(path: String) -> Array[String]:
	var file_paths: Array[String] = []
	var dir: DirAccess = DirAccess.open(path)
	
	dir.list_dir_begin()
	var file_name = dir.get_next()
	while file_name != "":
		var file_path = path + "/" + file_name
		
		if dir.current_is_dir():
			file_paths += get_all_file_paths(file_path)
		else:
			file_paths.append(file_path)
		
		file_name = dir.get_next()
	
	return file_paths
