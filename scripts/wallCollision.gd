extends RigidBody

onready var CollisionArea = get_node("CollisionArea")

func _ready():
	CollisionArea.connect("body_entered", self, "_on_collision_area_entered")
	pass

func _on_collision_area_entered(body):
	SignalSupervisor.emit_signal("player_collision", "obstacle")