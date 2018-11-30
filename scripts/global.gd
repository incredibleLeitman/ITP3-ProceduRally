extends Node

var playerWinner = "nobody"

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