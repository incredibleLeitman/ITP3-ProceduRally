extends KinematicBody

onready var pull_ray_down = get_node("CollisionRays/Down")
onready var repel_ray_down = get_node("RepelRays/Down")

var pull_speed = 8
var move_speed = Vector3(30, 0, 15)
var rot_speed = 18

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Handle rotation
	var rot = 0
	var movement = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("move_left"):
		#movement.z += -move_speed.z
		rotate_object_local(Vector3(0, 1, 0), 1 * delta)
		
	if Input.is_action_pressed("move_right"):
		#movement.z += move_speed.z
		rotate_object_local(Vector3(0, 1, 0), -1 * delta)

	# what the fuck
	# everything breaks without this
	rotation_degrees.x += 0;

	# Handle movement
	if Input.is_action_pressed("move_backward"):
		movement.x += -move_speed.x
		
	if Input.is_action_pressed("move_forward"):
		movement.x += move_speed.x
		
	# Handle gravity
	var pull_direction = Vector3()
	var pull_force = 0
	
	if pull_ray_down.is_colliding():
		# Get the pull force based on the difference of target and current collision point
		pull_direction = pull_ray_down.cast_to.normalized()
		pull_force = pull_ray_down.get_collision_point().distance_to(translation) - repel_ray_down.cast_to.length()
		pull_force *= pull_speed
		
		# Calculate upwards direction using the collision normal
		var normal = pull_ray_down.get_collision_normal()
		var diff = (normal - transform.basis.y)
		var rot_vector = diff * delta * rot_speed * diff.length()
		
		# Turn more the greater the difference, therefore multiply with length
		transform.basis.y += rot_vector
		transform.basis.y = transform.basis.y.normalized()
		
		transform.basis.x = transform.basis.y.cross(transform.basis.z).normalized()
		
	# Apply
	move_and_slide(transform.basis * (pull_direction * pull_force + movement))
