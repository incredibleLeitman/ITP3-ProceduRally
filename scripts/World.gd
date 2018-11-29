extends Spatial

onready var StartCast = get_node("StartCast")

func _ready():
	SignalSupervisor.emit_signal("spawn_new_pipes",
		StartCast.translation, StartCast.cast_to)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
