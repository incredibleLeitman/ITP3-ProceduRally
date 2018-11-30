extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	SignalSupervisor.emit_signal("spawn_obstacle", "wall")
	pass

func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
	pass
