extends Spatial

onready var StartCast = get_node("StartCast")

func _ready():
	# TODO: set from main menue
	var timer = get_node("Timer")
	timer.wait_time = global.trackLength
	timer.start()
	
	SignalSupervisor.emit_signal("spawn_new_pipes",
		StartCast.translation, StartCast.cast_to)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		# TODO: better use pause
		get_tree().change_scene("res://scenes/gameOver.tscn")

func _on_Timer_timeout():
	get_tree().change_scene("res://scenes/gameOver.tscn")
	#SignalSupervisor.emit_signal("music_stops") #TODO: use custom event?
