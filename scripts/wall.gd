extends RigidBody

# for animation
var velocity = Vector3()
var max_moved = Vector3()

# for collision
onready var CollisionArea = get_node("CollisionArea")

# TODO make a proper vector so it can spawn anywhere and still goes right direction (not only on y axis)
func _ready():
	# for collision
	CollisionArea.connect("body_entered", self, "_on_collision_area_entered")
	
	# for animation
	var size = get_child(0).mesh.size
	max_moved = Vector3(0, size.y * 2, 0)
	velocity = Vector3(0, 0.005 * size.y, 0)
	
	self.linear_velocity = velocity
	self.gravity_scale = 0
	
	#print("in ctor Wall with size: " + String(size))
	pass

func _process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var moved = self.transform.origin
	#print ("moved: " + str(moved) + " | max: " + str(max_moved))
	
	if(moved.y < max_moved.y):
		var velocity = self.linear_velocity
		self.linear_velocity = velocity * 1.1
	else:
		self.transform.origin = max_moved
		# print(self.transform.origin)
		self.linear_velocity = Vector3(0,0,0)
	
	pass

func _on_collision_area_entered(body):
	# for collision
	SignalSupervisor.emit_signal("player_collision", "obstacle")
	pass
