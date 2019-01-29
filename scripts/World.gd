extends Spatial

onready var StartCast = get_node("StartCast")

func _ready():
	# TODO: set from main menue
	var timer = get_node("Timer")
	if(global.trackLength != 0):
		timer.wait_time = global.trackLength
		timer.start()
	
	#SignalSupervisor.emit_signal("spawn_new_pipes",
	#	StartCast.translation, StartCast.cast_to)

	var exit_point = StartCast.translation
	var exit_dir = StartCast.cast_to
	
	if exit_point == null:
		global.printForType("Generic", "Exit Point not found!")
	elif exit_dir == null:
		global.printForType("Generic", "Exit dir not found!")
	else:
		SignalSupervisor.emit_signal("spawn_new_pipes", exit_point, exit_dir)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		# TODO: better use pause
		get_tree().change_scene("res://scenes/gameOver.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/gameOver.tscn")
	SignalSupervisor.emit_signal("music_stops") #TODO: use custom event?
