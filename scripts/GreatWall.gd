extends Spatial

onready var shape = get_node("MeshInstance/StaticBody/CollisionShape")

func _ready():
	toggle(false)

func toggle(new_val):
	visible = new_val
	shape.disabled = !new_val