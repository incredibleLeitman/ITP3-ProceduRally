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

func _on_spawn_new_pipes(new_entry, new_dir):
	# spawns new item fitting on new position
	var arr_seed = rand_seed(cur_seed)
	var type = abs(arr_seed[0])%Type.size()
	cur_seed = arr_seed[1]
	print("current seed: %d, type: %d" %[cur_seed, type])
	
	# spawn object depending on type
	# TODO: set pos, dir and special curve settings
	var new_pipe
	if type == Type.STRAIGHT:
		print("spawning straight on pos " + String(new_entry) + " (cur_pos: " + String(translation) + ")")
		new_pipe = pipe_sections["straight"].instance()
		new_pipe.translation = new_entry #TODO: +- offset
		new_pipe.transform.basis.z = new_dir.normalized()
		add_child(new_pipe)
		# after straight -> adding till curve
		SignalSupervisor.emit_signal("spawn_new_pipes",
			_on_spawn_new_pipes(to_global(new_pipe.ExitCast.translation), to_global(new_pipe.ExitCast.cast_to)))
	elif type == Type.CURVE:
		print("spawning curve")
		new_pipe = pipe_sections["curve"].instance()
		add_child(new_pipe)
	pass