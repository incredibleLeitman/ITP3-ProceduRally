extends KinematicBody

onready var pull_ray_down = get_node("CollisionRays/Down")
onready var repel_ray_down = get_node("RepelRays/Down")

var pull_speed = 12
var move_speed = Vector3(20, 0, 8)
var rot_speed = 20

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	# Handle rotation
	var rot = 0
	var movement = Vector3()
	
	if Input.is_action_pressed("move_left"):
		#rot -= delta * rot_speed
		movement.x += -move_speed.z # TODO weird coordinates
		
	if Input.is_action_pressed("move_right"):
		#rot += delta * rot_speed
		movement.x += move_speed.z

	rotation_degrees.x += rot;

	# Handle movement
	if Input.is_action_pressed("move_backward"):
		movement.z -= -move_speed.x # TODO weird coordinates
		
	if Input.is_action_pressed("move_forward"):
		movement.z += -move_speed.x # TODO weird coordinates
		
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
		
		# Turn more the greater the difference, therefore multiply with length
		transform.basis.y += diff * delta * rot_speed * diff.length()
		
	# Apply
	move_and_slide(pull_direction * pull_force + movement)
