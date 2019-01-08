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

export var playerName = ""
export var passedSections = 0

const UP = Vector3(0, 1, 0)
const FORWARD = Vector3(1, 0, 0)

var initial_speed = 30
var increase_per_second = 0.3

var auto_speed = false

var just_collided = false

func _ready():
	if (auto_speed == true):
		move_speed.x = initial_speed

	# connect to collider event handling
	SignalSupervisor.connect("player_collision", self, "_on_collision")

func _on_collision(what):
	# TODO: distinguish between different objects
	print("player collision with " + what)
	#case 1: gravityChanger
	if (what == "gravityChangeWall"):
		transform.basis = transform.basis.rotated(transform.basis.x, PI)
	elif (what == "speedBoost"):
		move_speed.x = move_speed.x * 1.1
	elif (what == "wall"):
		move_speed.x = initial_speed
	
	# TODO: Make pull_speed lower and slowly go back to default value
	
	just_collided = true # signal asynchronous -> wait 1 frame

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
	
	if (auto_speed == false):
		if Input.is_action_pressed("move_backward"):
			movement.x += -move_speed.x

		if Input.is_action_pressed("move_forward"):
			movement.x += move_speed.x
	else:
		movement.x = move_speed.x	
		move_speed.x += increase_per_second * delta
		
	# Handle gravity
	var pull_direction = Vector3()
	var pull_force = 0
	
	if pull_ray_down.is_colliding() and not just_collided:
		# Get the pull force based on the difference of target and current collision point
		pull_direction = pull_ray_down.cast_to.normalized()
		pull_force = pull_ray_down.get_collision_point().distance_to(translation) - repel_ray_down.cast_to.length()
		pull_force *= pull_speed
		
		# Calculate upwards direction using the collision normal
		var normal = pull_ray_down.get_collision_normal()
		var diff = (normal - transform.basis.y)
		var rot_vector = diff * delta * normalize_rot_speed * diff.length()
		
		#print(normal)
		
		# Turn more the greater the difference, therefore multiply with length
		transform.basis.y += rot_vector
		transform.basis.y = transform.basis.y.normalized()
		transform.basis.x = transform.basis.y.cross(transform.basis.z).normalized()
		
		transform.basis = transform.basis.orthonormalized()
		
	# Apply
	move_and_slide(transform.basis * (pull_direction * pull_force + movement))
	
	just_collided = false
