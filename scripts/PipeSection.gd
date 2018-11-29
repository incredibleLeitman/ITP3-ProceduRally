extends Spatial

onready var Entry = get_node("Entry")
onready var Exit = get_node("Exit")

onready var EntryCast = Entry.get_node("EntryPoint")
onready var ExitCast = Exit.get_node("ExitPoint")

onready var EntryArea = Entry.get_node("EntryArea")
onready var ExitArea = Exit.get_node("ExitArea")

export(bool) var spawns_new_pipes = false

func _ready():
	EntryArea.connect("body_entered", self, "_on_entry_area_entered")
	ExitArea.connect("body_entered", self, "_on_exit_area_entered")

func get_exit_point():
	return Exit.to_global(ExitCast.translation)
	
func get_exit_dir():
	var new = transform.basis * ExitCast.cast_to
	print("Before: " + String(ExitCast.cast_to))
	print("After: " + String(new))
	return new

func _on_entry_area_entered(body):
	if spawns_new_pipes:
		SignalSupervisor.emit_signal("spawn_new_pipes",
			get_exit_point(), get_exit_dir())
		ExitArea.queue_free() # to prevent spawning sections again

func _on_exit_area_entered(body):
	# remove passed pipe section
	queue_free()