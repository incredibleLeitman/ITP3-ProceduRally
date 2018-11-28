extends Spatial

var obstacles = {
	"wall": preload("res://scenes/wall.tscn")
}

func _ready():
	SignalSupervisor.connect("spawn_obstacle", self, "spawn_obstacle")

func spawn_obstacle(name):
	if not obstacles.has(name):
		print("Error: No obstacle with name %s" % [name])
		return
	
	var new_node = obstacles[name].instance()
	add_child(new_node)