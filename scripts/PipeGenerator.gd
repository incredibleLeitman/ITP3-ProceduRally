extends Spatial

var cur_seed
enum Type {STRAIGHT, CURVE}

var pipe_sections = {
	"straight": preload("res://scenes/StraightPipeSection.tscn"),
	"curve": preload("res://scenes/CurvedPipeSection.tscn")
}

func _ready():
	SignalSupervisor.connect("spawn_new_pipes", self, "_on_spawn_new_pipes")
	cur_seed = randi()
	# Called when the node is added to the scene for the first time.
	# Initialization here
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
	
	if new_dir == Vector3(0, 0, 1):
		# same
		pass
	elif new_dir == Vector3(1, 0, 0):
		new_pipe.transform.basis.z = Vector3(1, 0, 0)
		new_pipe.transform.basis.x = Vector3(0, 0, 1)
	elif new_dir == Vector3(0, 1, 0):
		new_pipe.transform.basis.z = Vector3(0, 1, 0)
		new_pipe.transform.basis.y = Vector3(0, 0, 1)
	
	print("I am a " + name + " and my dir is " + String(new_dir))
	# Failed approaches for random rotation :(
	#new_pipe.transform = new_pipe.transform.rotated(new_pipe.to_local(Vector3(0, 0, 1)), 1)
	#new_pipe.rotate_object_local(Vector3(0, 0, 1), get_next_random() / 1000)
	add_child(new_pipe)
	
	if name == "straight":
		SignalSupervisor.emit_signal("spawn_new_pipes",
			_on_spawn_new_pipes(new_pipe.get_exit_point(), new_pipe.get_exit_dir()))
	