extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	# Connect button signals to enable navigation
	for button in $Menu/CenterRow/Buttons.get_children():
		button.connect("pressed", self, "_on_Button_pressed", [button.sceneToLoad])


# When Menu buttons are pressed
func _on_Button_pressed(sceneToLoad):
	get_tree().change_scene(sceneToLoad)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
