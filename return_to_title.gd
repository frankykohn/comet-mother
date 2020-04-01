extends Control

	
func _on_StartButton_pressed():
	GameStartAudio.play()
	OpeningThemeAudio.stop()
	get_tree().change_scene('res://Gameplay.tscn')
	

func	 _on_Back_pressed():
	MenuBackAudio.play()
	get_tree().change_scene('res://MenuScreen.tscn')


func _on_AboutButton_pressed():
	MenuForwardAudio.play()
	get_tree().change_scene('res://AboutScreen.tscn')
	


func _on_CreditsButton_pressed():
	MenuForwardAudio.play()
	get_tree().change_scene('res://CreditsScreen.tscn')
	



