extends Control

	
func _on_StartButton_pressed():
	GameStartAudio.play()
	OpeningThemeAudio.stop()
	get_tree().change_scene("res://src/World/Levels/Gameplay.tscn")
	

func	 _on_Back_pressed():
	MenuBackAudio.play()
	get_tree().change_scene("res://src/UI/MainMenu/MenuScreen.tscn")


func _on_AboutButton_pressed():
	MenuForwardAudio.play()
	get_tree().change_scene("res://src/UI/MainMenu/AboutScreen.tscn")
	


func _on_CreditsButton_pressed():
	MenuForwardAudio.play()
	get_tree().change_scene("res://src/UI/MainMenu/CreditsScreen.tscn")
	



