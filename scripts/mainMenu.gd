extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var menuNavigation = 0;


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	get_node("Container/HBoxContainer/VBoxContainer/volume/vslide").value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	hide_show()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func _on_exit_pressed():
	get_tree().quit()


func _on_start_game_pressed():
	get_tree().change_scene("res://scenes/World.tscn")


#Menu Navigation

func _on_single_player_pressed():
	menuNavigation = 1
	hide_show()
	
func _on_multi_player_pressed():
	menuNavigation = 4
	hide_show()


func _on_host_pressed():
	menuNavigation = 2
	hide_show()


func _on_join_pressed():
	menuNavigation = 3
	hide_show()
	

func _on_options_pressed():
	menuNavigation = 5
	hide_show()


func hide_show():
	var hideAllChildren = get_node("Container/HBoxContainer/VBoxContainer").get_children()
	for i in hideAllChildren:
		i.hide()
	
	if(menuNavigation == 0):
		get_node("Container/HBoxContainer/VBoxContainer/single_player").show()
		get_node("Container/HBoxContainer/VBoxContainer/multi_player").show()
		get_node("Container/HBoxContainer/VBoxContainer/options").show()
		get_node("Container/HBoxContainer/VBoxContainer/exit").show()
	elif(menuNavigation == 1 || menuNavigation == 2):
		get_node("Container/HBoxContainer/VBoxContainer/start_game").show()
		get_node("Container/HBoxContainer/VBoxContainer/song_selection").show()
		get_node("Container/HBoxContainer/VBoxContainer/song_duration").show()
		get_node("Container/HBoxContainer/VBoxContainer/back").show()
	elif(menuNavigation == 3):
		get_node("Container/HBoxContainer/VBoxContainer/start_game").show()
		get_node("Container/HBoxContainer/VBoxContainer/back").show()
	elif(menuNavigation == 4):
		get_node("Container/HBoxContainer/VBoxContainer/host").show()
		get_node("Container/HBoxContainer/VBoxContainer/join").show()
		get_node("Container/HBoxContainer/VBoxContainer/back").show()
	elif(menuNavigation == 5):
		get_node("Container/HBoxContainer/VBoxContainer/volume").show()
		get_node("Container/HBoxContainer/VBoxContainer/back").show()

func _on_back_pressed():
	
	if(menuNavigation == 1 || menuNavigation == 4 || menuNavigation == 5):
		menuNavigation = 0
		hide_show()
	elif(menuNavigation == 2 || menuNavigation == 3):
		menuNavigation = 4
		hide_show()


#VOLUME & Sounds
func _on_vslide_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value)


func _on_AudioStreamPlayer_finished():
	var player = get_node("AudioStreamPlayer")
	player.playing = true
