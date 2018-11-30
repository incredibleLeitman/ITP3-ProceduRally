extends Spatial

var pipeSize = 20
var scaleVar = 5

var obstacles = {
	"wall": preload("res://scenes/AnimateWall.tscn")
}

func _ready():
	SignalSupervisor.connect("spawn_obstacle", self, "spawn_obstacle")

func spawn_obstacle(name):
	# TODO generalize the function again 
	
	if not obstacles.has(name):
		print("Error: No obstacle with name %s" % [name])
		return
	
	var scaleVec = Vector3(1,1,1) * scaleVar
	
	var new_node = obstacles[name].instance()
	new_node.global_scale(scaleVec)
	
	# TODO make a vector that properly represents the translation depending on position spawned
	new_node.set_translation(Vector3(0, -(pipeSize/2) - scaleVar, 0))
	add_child(new_node)