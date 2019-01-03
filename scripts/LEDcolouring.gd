extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var mat = preload("res://materials/LED.tres")

func _ready():
	var material = mat.duplicate()
	get_node("MeshInstance").set_material_override(material) 
	SignalSupervisor.connect("change_colour", self, "_on_change_colour")
	SignalSupervisor.emit_signal("change_colour", global.get_curCol())
	pass
	
func _on_change_colour(colour):
	#print("Get Node Name: " + get_node("./").get_parent().name)
	if (get_node("./").get_parent().name == "Lights"):
		set_colour(colour)
	pass
	
func set_colour(colour):
	#print("changing color")
	get_node("OmniLight").light_color = colour
	get_node("MeshInstance").get_mesh().material.albedo_color = colour
	get_node("MeshInstance").get_mesh().material.emission = colour
	pass

#func _process(delta):
#	#print(get_node("OmniLight").light_color)
#	# Update game logic here.
#	pass
