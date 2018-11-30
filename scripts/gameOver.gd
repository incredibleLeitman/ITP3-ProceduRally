extends Node

func _ready():
	#var labelWinner = get_child("LabelWinner")
	#var labelWinner = get_tree().get_root().find_node("LabelWinner")
	var labelWinner = get_node("CenterContainer/HBoxContainer/LabelWinner")
	labelWinner.text = labelWinner.text.replace("%Player", global.playerWinner)

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
