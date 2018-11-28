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

func _on_entry_area_entered(body):
	if spawns_new_pipes:
		SignalSupervisor.emit_signal("spawn_new_pipes",
			to_global(ExitCast.translation), to_global(ExitCast.cast_to))
		ExitArea.queue_free() # to prevent spawning sections again

func _on_exit_area_entered(body):
	# remove passed pipe section
	queue_free()