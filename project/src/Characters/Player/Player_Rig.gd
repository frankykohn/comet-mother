extends RigidBody2D

signal collectNectar(value)

var velocity = Vector2()
var noKeyPress = false;
var look_direction = Vector2(1,0)
var soundFxArray = []
var files = []
onready var player = $AudioStreamPlayer
export (int) var speed = 150
var rand_generate = RandomNumberGenerator.new()
var sound = AudioStreamPlayer.new()
var value = 0

func _ready():
	add_child(sound)
	set_contact_monitor(true)
	#connect("collectNectar", get_node("../GUI"), "_on_collect_nectar", [value])
	get_viewport().audio_listener_enable_2d = true
	var dir = Directory.new()
	if dir.open("res://src/World/Levels/assets") == OK:
		dir.list_dir_begin()
		var file = dir.get_next()
		while (file != ""):
			if file.begins_with("key press") and file.ends_with("wav"):
				soundFxArray.append(load("res://src/World/Levels/assets/" + file))
			file = dir.get_next()
		#print(soundFxArray.size())
	
	
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if Input.is_key_pressed(KEY_RIGHT):
		apply_central_impulse(Vector2.RIGHT * speed)
		
		
	if Input.is_key_pressed(KEY_LEFT):
		apply_central_impulse(Vector2.LEFT * speed)
	if Input.is_key_pressed(KEY_UP):
		apply_central_impulse(Vector2.UP * speed)
	if Input.is_key_pressed(KEY_DOWN):
		apply_central_impulse(Vector2.DOWN * speed)
		
	if abs(get_linear_velocity().x) > speed or abs(get_linear_velocity().y) > speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= speed
		set_linear_velocity(new_speed)

	if abs(get_linear_velocity().length()) < 149 and abs(get_linear_velocity().length()) > 0:
		set_linear_velocity(Vector2(0,0))

func _on_CharacterRig_body_shape_entered(body_id, body, body_shape, local_shape):
	#print(body.get_name())
	randomize()
	var randNum = rand_generate.randi_range(0, soundFxArray.size() - 1)
	sound.set_stream(soundFxArray[randNum])
	sound.play()
	value += 1
	emit_signal("collectNectar", value)
	#print("reached after sound.play()")
	if "NectarBubble" in body.get_name():
		body.queue_free()
		
		

func _physics_process(delta):
	var input_direction = get_input_direction()
	update_look_direction(input_direction)


func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_key_pressed(KEY_RIGHT)) - int(Input.is_key_pressed(KEY_LEFT))
	input_direction.y = int(Input.is_key_pressed(KEY_DOWN)) - int(Input.is_key_pressed(KEY_UP))
	return input_direction


func update_look_direction(input_direction):
	if input_direction:
		look_direction = input_direction
	if not input_direction.x in [-1, 1]:
		return

	
	
	
	
