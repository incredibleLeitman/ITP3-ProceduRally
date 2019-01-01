extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	#_on_change_colour("ffffff")
	SignalSupervisor.connect("change_colour", self, "_on_change_colour")
	pass
	
func _on_change_colour(colour):
	print("test...")
	get_node("OmniLight").light_color = colour
	get_node("MeshInstance").get_mesh().material.albedo_color = Color(colour)
	get_node("MeshInstance").get_mesh().material.emission = Color(colour)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
