extends Control
	
func _ready():
	$OpeningMusic.play()
	
func _on_Start_pressed():
	$OpeningMusic.stop()
	$ButtonPressForward.play()
	get_tree().change_scene("res://src/UI/StarMap/StarMap.tscn")
	 # Replace with function body.

func _on_About_pressed():
	$OpeningMusic.stop()
	$ButtonPressForward.play()
	get_tree().change_scene("res://src/UI/MainMenu/AboutScreen.tscn")


func _on_Menu_pressed():
	$OpeningMusic.stop()
	$ButtonPressForward.play()
	get_tree().change_scene("res://src/UI/MainMenu/CreditsScreen.tscn")
