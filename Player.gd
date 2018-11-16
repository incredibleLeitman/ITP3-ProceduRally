extends Spatial

onready var rays = get_node("CollisionRays")

var col_speed = 3

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	var direction = Vector3(0, 0, 0)
	
	for ray in rays.get_children():
		if ray.is_colliding():
			
			var weighted_distance = (7 - ray.get_collision_point().distance_to(translation)) / 7
			direction += ray.cast_to.normalized() * weighted_distance * delta * col_speed
		
	translation += direction
	
	if Input.is_action_pressed("move_left"):
		rotation_degrees.z += delta * 100
		
	if Input.is_action_pressed("move_right"):
		rotation_degrees.z -= delta * 100
