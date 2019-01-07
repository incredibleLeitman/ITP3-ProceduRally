extends Node

var part_dict = MusicData.get_parts_dict()
var current_part

onready var player = get_node("AudioStreamPlayer")

var cur_seed = 7

func get_next_random():
	var arr_seed = rand_seed(cur_seed)
	var type = abs(arr_seed[0])
	cur_seed = arr_seed[1]
	
	return type

func _ready():
	for item in part_dict.values():
		item.loaded_scene = load(item.music_file)
	
	player.connect("finished", self, "_on_player_finished")
	play_part("default")
	
func play_part(name):
	current_part = name
	player.stream = part_dict[name].loaded_scene
	player.seek(0)
	player.playing = true
	
	# LEDs that change colour depending on music
	var propCol = Color(part_dict[current_part].color[0], part_dict[current_part].color[1], part_dict[current_part].color[2], part_dict[current_part].color[3])
	global.set_curCol(propCol)
	SignalSupervisor.emit_signal("change_colour", propCol)

func _on_player_finished():
	var possibilities = part_dict[current_part].parts_after
	var which = get_next_random() % possibilities.size()
	
	play_part(possibilities[which])
	
	var obstacles = part_dict[current_part].obstacles_spawned
	# insert in queue --> TODO: maybe block for thread safety?
	if (global.setObstacles(obstacles) == true):
		SignalSupervisor.emit_signal("spawn_obstacles")
	
	
