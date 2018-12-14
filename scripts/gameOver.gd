extends Node

func _ready():
	var labelWinner = get_node("CenterContainer/HBoxContainer/LabelWinner")
	#TODO get player name and passedPipes from superior sources (aerver?)
	labelWinner.text = labelWinner.text.replace("%player", global.playerWinner)
	labelWinner.text = labelWinner.text.replace("%amount", global.passedSections)

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/mainMenu.tscn")
