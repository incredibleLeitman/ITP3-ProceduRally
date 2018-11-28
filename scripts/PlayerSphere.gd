tool
extends Spatial

onready var light = get_node("OmniLight")
onready var sphere = get_node("SphereMesh")

var base_glow = 2;
var glow_multiplier = 2.5;

var time = 0 # Keeps track of time for beat effect
var bpm # beats per minute

var beat_duration_multiplier # frequency of beat

func _ready():
	set_bpm(120)
	set_color(Color(1, 0, 0))
	
func set_bpm(new_bpm):
	bpm = new_bpm
	beat_duration_multiplier = bpm/60
	
func set_color(new_color):
	light.light_color = new_color
	
	var mat = SpatialMaterial.new()
	mat.albedo_color = new_color
	mat.rim_enabled = true
	mat.metallic = 0.8
	mat.metallic_specular = 1
	mat.roughness = 0.9
	
	sphere.set_surface_material(0, mat)

func _process(delta):
	time += delta * beat_duration_multiplier
	
	# Add PI/2 to get rid of negative values;
	# multiply time with 2*PI so we get one glow cycle per time unit (= beat)
	light.light_energy = base_glow + PI/2 + sin(time * 2*PI) * glow_multiplier