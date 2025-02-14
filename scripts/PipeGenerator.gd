extends Spatial

var cur_seed
#var spawned_sections
enum Type {STRAIGHT, CURVE}

var pipe_sections = {
	"straight": preload("res://scenes/StraightPipeSection.tscn"),
	"curve": preload("res://scenes/CurvedPipeSection.tscn")
}

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	SignalSupervisor.connect("spawn_new_pipes", self, "_on_spawn_new_pipes")
	cur_seed = randi()
	#spawned_sections = 0
	pass
	
func get_next_random():
	var arr_seed = rand_seed(cur_seed)
	var type = abs(arr_seed[0])
	cur_seed = arr_seed[1]
	return type

func _on_spawn_new_pipes(new_entry, new_dir):
	# spawns new item fitting on new position
	var type = get_next_random() % Type.size()
	
	new_entry = to_local(new_entry)
	
	# spawn object depending on type
	if type == Type.STRAIGHT:
		spawn_section("straight", new_entry, new_dir)
	elif type == Type.CURVE:
		spawn_section("curve", new_entry, new_dir)
	pass
	
func spawn_section(name, new_entry, new_dir):
	var new_pipe = pipe_sections[name].instance()
	new_pipe.translation = new_entry
	
	# Get a random direction
	var rand_vec = Vector3(get_next_random() - get_next_random(), get_next_random() - get_next_random(), get_next_random() - get_next_random())

	# Apply new_dir to z basis and rotate randomly using a cross product with rand_vec
	new_pipe.rotate(new_pipe.transform.basis.z.cross(new_dir), new_pipe.transform.basis.z.angle_to(new_dir))
	new_pipe.transform.basis.z = new_dir
	new_pipe.transform.basis.x = rand_vec.cross(new_dir).normalized()
	new_pipe.transform.basis.y = new_pipe.transform.basis.x.cross(new_pipe.transform.basis.z).normalized()
	
	global.printForType("PipeGenerator", "Section spawn: " + name + " on point " + String(new_entry) + " with dir: " + String(new_dir))
	add_child(new_pipe)
	#spawned_sections += 1
	#global.printForType("PipeGenerator", "spawned_sections: " + String(spawned_sections))
	global.printForType("PipeGenerator", "PipeGenerator having " + String(get_children().size()) + "children")
	
	# check for current obstacles and add them to new pipes
	#var globstacles = global.getObstacles()
	#printForType("PipeGenerator", "calling spawn obstacles from PipeGenerator with list: " + String(globstacles))
	SignalSupervisor.emit_signal("spawn_obstacles")
	
	# spawn more pipes until reach a curve
	if name == "straight": # || spawned_sections == 1:
		var exit_point = new_pipe.get_exit_point()
		var exit_dir = new_pipe.get_exit_dir()
		if exit_point == null:
			global.printForType("PipeGenerator", "Exit Point not found!")
		elif exit_dir == null:
			global.printForType("PipeGenerator", "Exit dir not found!")
		else:
			SignalSupervisor.emit_signal("spawn_new_pipes", exit_point, exit_dir)
	#else:
	#	spawned_sections = 0
	