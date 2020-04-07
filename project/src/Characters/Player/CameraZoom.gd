extends Camera2D

export var speed = 10.0
export var zoomspeed = 10.0
export var zoommargin = 0.1

export var zoomMin = 0.2
export var zoomMax = 2.0

onready var path = get_node("../../../")
onready var camOffsetNode = get_node("../")

var zoompos = Vector2()
var zoomfactor = 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	pass
	
func _input(event):
	
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:	
				if zoomfactor > 1.0:
					zoomfactor = 1.0
					 
				if zoomfactor < 1.0:
					var child = get_node("../Camera2D")
					get_node("../").remove_child(child)
					path.add_child(child)
					
				zoomfactor -= 0.1
				#zoompos = path.position
				zoom()
			if event.button_index == BUTTON_WHEEL_DOWN:
				if zoomfactor >= 0.2 and zoomfactor < 1.0:
					zoomfactor = 1.0	
					if path.get_node("Camera2D"):
						var child = path.get_node("Camera2D")
						path.remove_child(child)
						camOffsetNode.add_child(child)
						
				zoomfactor +=0.1
				#zoompos = path.position
				zoom()


func zoom():
	zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * 0.1)
	zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * 0.1)
	zoom.x = clamp(zoom.x, zoomMin, zoomMax)
	zoom.y = clamp(zoom.y, zoomMin, zoomMax)
