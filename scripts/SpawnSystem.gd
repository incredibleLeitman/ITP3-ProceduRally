extends Spatial

var pipeSize = 20
var scaleVar = 5
var scaleVec = Vector3(1, 1, 1) * scaleVar

var obstacles = {
	"empty": "",
	"wall": preload("res://scenes/wall.tscn"),
	"gravityChanger": preload("res://scenes/GravityChangeWall.tscn")
}

func _ready():
	SignalSupervisor.connect("spawn_obstacle", self, "_on_spawn_obstacle")

func _on_spawn_obstacle(name):
	# TODO generalize the function again
	if not obstacles.has(name):
		print("Error: No obstacle with name %s" % [name])
		return

	# remove existing other obstacles:
	for node in get_children():
		# TODO: setup base type for obstacles
        #if(node.is_type(type)):
		if (node.get_name().begins_with(name) == false): # remove all non-current-obstacles
			node.free()

	if name == "empty": # do not create empty obsticles, just remove current
		return 

	# creating new obsticle:
	var new_node = obstacles[name].instance()
	new_node.set_name(name + String(get_children().size()))
	#new_node.global_scale(scaleVec) # EDITED lem: throws error "!is_inside_tree() ' is true. returned: Transform()" because is not (yet) in tree --> moved after adding to tree
	
	# TODO: make a vector that properly represents the translation depending on position spawned
	new_node.set_translation(Vector3(0, -(pipeSize/2) - scaleVar, 0))
	print("adding obsticle of type: " + name + " with name: " + new_node.get_name() + " to " + self.get_name())
	add_child(new_node)
	new_node.global_scale(scaleVec)
	