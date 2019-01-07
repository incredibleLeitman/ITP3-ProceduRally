extends Spatial

var pipeSize = 20
var scaleVar = 5
var scaleVec = Vector3(1, 1, 1) * scaleVar

var obstacles = {
	"empty": "",
	"wall": preload("res://scenes/wall.tscn"),
	"gravityChanger": preload("res://scenes/GravityChangeWall.tscn"),
	"speedBoost": preload("res://scenes/SpeedBoost.tscn")
}

func _ready():
	#SignalSupervisor.connect("spawn_obstacle", self, "_on_spawn_obstacle")
	SignalSupervisor.connect("spawn_obstacles", self, "_on_spawn_obstacles")

func _on_spawn_obstacles ():
	var globstacles = global.getObstacles()
	print("spawning obstacles: " + String(globstacles))
	# remove existing other obstacles:
	for node in get_children():
		# TODO: setup base type for obstacles
		var contains = false;
		for obstacle in globstacles:
			if (node.get_name().begins_with(obstacle)): 
				contains = true
				globstacles.erase(obstacle) # obstacle already exists -> not spawn again
				break

		if (contains == false): # current obstacle should not be present
			print("removing " + node.get_name())
			node.free()

	for obstacle in globstacles:
		if not obstacles.has(obstacle):
			continue
	
		# creating new obstacle:
		print("creating obstacle: " + obstacle)
		var new_node = obstacles[obstacle].instance()
		new_node.set_name(obstacle + String(get_children().size()))
		#new_node.global_scale(scaleVec) # EDITED lem: throws error "!is_inside_tree() ' is true. returned: Transform()" because is not (yet) in tree --> moved after adding to tree
		
		# TODO: make a vector that properly represents the translation depending on position spawned
		new_node.set_translation(Vector3(0, -(pipeSize/2) - scaleVar, 0))
		print("adding obsticle of type: " + obstacle + " with name: " + new_node.get_name() + " to " + self.get_name())
		add_child(new_node)
		new_node.global_scale(scaleVec)
	