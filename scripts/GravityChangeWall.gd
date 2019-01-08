extends Spatial

# for collision
onready var CollisionArea = get_node("CollisionArea")

func _ready():
	# for collision
	CollisionArea.connect("body_entered", self, "_on_collision_area_entered")
	pass

func _on_collision_area_entered(body):
	# for collision
	SignalSupervisor.emit_signal("player_collision", "gravityChangeWall")
	pass