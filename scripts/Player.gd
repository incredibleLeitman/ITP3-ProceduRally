extends KinematicBody

onready var pull_ray_down = get_node("CollisionRays/Down")
onready var repel_ray_down = get_node("RepelRays/Down")

var pull_speed = 8
var move_speed = Vector3(30, 0, 18)
var normalize_rot_speed = 18
# variables for rotation
var move_rot_speed_max = 1.5
var move_rot_speed_cur = 0
var move_rot_speed_acc = 10

export var passedSections = 0

const UP = Vector3( 0, 1, 0 )

var initial_speed = 30
var increase_per_second = 0.3

func _ready():
	move_speed.x = initial_speed

func _process(delta):
	# Handle movement
	var movement = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("ui_left"):
		move_rot_speed_cur += move_rot_speed_acc * delta
		movement.z += move_speed.z
		#rotate_object_local(Vector3(0, 1, 0), 1 * delta)
	elif Input.is_action_pressed("move_right") || Input.is_action_pressed("ui_right"):
		move_rot_speed_cur -= move_rot_speed_acc * delta
		movement.z -= move_speed.z
		#rotate_object_local(Vector3(0, 1, 0), -1 * delta)
	elif move_rot_speed_cur != 0:
		move_rot_speed_cur -= move_rot_speed_cur/abs(move_rot_speed_cur) * move_rot_speed_acc/2 * delta
		
	move_rot_speed_cur = clamp(move_rot_speed_cur, -move_rot_speed_max, move_rot_speed_max)
	rotate_object_local(UP, move_rot_speed_cur * delta)

	# what the fuck
	# everything breaks without this
	rotation_degrees.x += 0;
	
	movement.x = move_speed.x

#	if Input.is_action_pressed("move_backward"):
#		movement.x += -move_speed.x

#	if Input.is_action_pressed("move_forward"):
#		movement.x += move_speed.x

	move_speed.x += increase_per_second * delta
		
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
		var rot_vector = diff * delta * normalize_rot_speed * diff.length()
		
		# Turn more the greater the difference, therefore multiply with length
		transform.basis.y += rot_vector
		transform.basis.y = transform.basis.y.normalized()
		
		transform.basis.x = transform.basis.y.cross(transform.basis.z).normalized()
		
	# Apply
	move_and_slide(transform.basis * (pull_direction * pull_force + movement))
