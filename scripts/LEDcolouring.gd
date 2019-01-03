extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	if (get_node("./").get_parent().name == "Lights"):
		SignalSupervisor.connect("change_colour", self, "_on_change_colour")
		SignalSupervisor.emit_signal("change_colour", global.get_curCol())
	pass
	
func _on_change_colour(colour):
	get_node("OmniLight").light_color = colour
	get_node("MeshInstance").get_mesh().material.albedo_color = colour
	get_node("MeshInstance").get_mesh().material.emission = colour
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
