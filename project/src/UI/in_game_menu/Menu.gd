extends VBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var buttonRestart = $CenterRow/Buttons/RestartButton
onready var buttonQuit = $CenterRow/Buttons/QuitButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Settings_pressed():
	print("pressed settings button")
	get_tree().paused = not get_tree().paused
	buttonRestart.visible = not buttonRestart.visible
	buttonQuit.visible = not buttonQuit.visible
	 # Replace with function body.



func _on_RestartButton_pressed():
	get_tree().change_scene("res://src/World/Levels/Gameplay.tscn")
	get_tree().paused = not get_tree().paused


func _on_QuitButton_pressed():
	get_tree().quit()
