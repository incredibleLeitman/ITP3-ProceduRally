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
	
	var rot = 0;
	if Input.is_action_pressed("move_left"):
		rot += delta * 100
		
	if Input.is_action_pressed("move_right"):
		rot -= delta * 100

	# cap at 90 °
	var new_rot_z = rotation_degrees.z + rot
	#if new_rot_z < 90 && new_rot_z > -90:
	if new_rot_z < 45 && new_rot_z > -45:
		rotation_degrees.z += rot;
	print("degrees.z:" + str(rotation_degrees.z))

	if Input.is_action_pressed("move_forward"):
		translation -= Vector3(0, 0, delta * 100)
