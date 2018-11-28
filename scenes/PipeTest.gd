extends Spatial

var time = 0
var has_done_it = false

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	time += delta
	
	if time > 3 and not has_done_it:
		SignalSupervisor.emit_signal("spawn_obstacle", "wall")
		has_done_it = true