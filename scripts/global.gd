extends Node

var playerWinner = "nobody"
var passedSections = 0
var trackLength = 400 #length of the track in seconds -> TODO: make GUI elements for this

#global array to notify pipe sections with obstacles to spawn
var globstacles = []
func setObstacles (var i_obs):
	if (i_obs != globstacles):
		global.printForType("ObstacleSpawner", "setting obstacles to: " + String(i_obs))
		globstacles = i_obs
		return true
		
	global.printForType("ObstacleSpawner", "obstacles not changed")
	return false
	
func getObstacles ():
	return globstacles.duplicate()

#global array for current light colour
#var curCol = []
var curCol
func set_curCol(colour):
	curCol = colour
	pass

func get_curCol():
	#return curCol.duplicate()
	return curCol
	
var debug = true
var debugFlags = [
	"Generic",
	#"ObstacleSpawner",
	"PipeGenerator"
	#"CollisionHandling"
	]

func printForType (var text, var type):
	if debug && debugFlags.has(type):
		print(text)
	

# TODO: maybe insert global event here? (Pause, Escape...? )
#func _process(delta):
#	if Input.is_action_pressed("ui_accept"):
#		print("game paused")
#		if (get_tree().paused == false):
#			get_tree().paused = true
#		else:
#			get_tree().paused = false
#		# TODO: pause popup menue
		#$pause_popup.show()
		
#func _on_pause_popup_close_pressed():
#    $pause_popup.hide()
#    get_tree().paused = false