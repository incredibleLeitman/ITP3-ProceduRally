extends Node

var data

func _init():
	var data_file = File.new()
	
	if data_file.open("res://music/music.json", File.READ) != OK:
		print("Couldn't read music from JSON!")
		
	var data_text = data_file.get_as_text()
	data_file.close()
	
	var data_parse = JSON.parse(data_text)
	
	if data_parse.error != OK:
		print("Music could not be parsed from JSON!")
		
	data = data_parse.result
	
func get_all_parts():
	return data
	
func get_part(name):
	return data[name]
	
func get_color_for_part(name):
	var color = get_part(name).color
	return Color(color[0], color[1], color[2], color[3])
	
func get_obstacles_for_part(name):
	return get_part(name).obstacles_spawned
	
func get_parts_after_part(name):
	return get_part(name).parts_after
	
func get_music_file_for_part(name):
	return get_part(name).music_file
	
func get_parts_dict():
	var dict = {}
	
	var keys = data.keys()
	
	for i in range(0, keys.size()):
		dict[keys[i]] = get_part(keys[i])
		
	return dict