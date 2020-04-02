extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed = 0.005
var location = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$Path2D/PathFollow2D/AudioStreamPlayer2D.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Path2D/PathFollow2D").set_unit_offset(location)
	location += speed


func _on_EnemyChangePathTimer_timeout():
	get_node("/root").position.x = get_global_transform_with_canvas().origin.x
	get_node("/root").position.y = get_global_transform_with_canvas().origin.y
	$Path2D.set_unit_offset(0)
