extends RigidBody2D

signal collectNectar(value)
signal updateHealth(value, value)

const FLASH_RATE = 0.05
const N_FLASHES = 4

var velocity = Vector2()
var noKeyPress = false;
var look_direction = Vector2(1,0)
var maxHealth = 100
var health = maxHealth
var damage = 0

var soundFxArray = []
var files = []

onready var player = $AudioStreamPlayer
onready var health_over = get_node("../GUI/HealthOver")
onready var health_under = get_node("../GUI/HealthUnder")
onready var update_tween = get_node("../GUI/UpdateTween")

export (int) var speed = 150
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red

export (float, 0, 1, 0.05) var danger_zone = 0.4

var rand_generate = RandomNumberGenerator.new()
var sound = AudioStreamPlayer.new()
var value = 0

func _ready():
	add_child(sound)
	set_contact_monitor(true)
	#connect("collectNectar", get_node("../GUI"), "_on_collect_nectar", [value])
	connect("updateHealth", self, "_on_update_health", [health, damage])
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
	health_over.value = maxHealth
	health_under.value = maxHealth
	
	
func _integrate_forces(state: Physics2DDirectBodyState) -> void:
	if Input.is_action_pressed("ui_right"):
		apply_central_impulse(Vector2.RIGHT * speed)
		
	if Input.is_action_pressed("ui_left"):
		apply_central_impulse(Vector2.LEFT * speed)
	if Input.is_action_pressed("ui_up"):
		apply_central_impulse(Vector2.UP * speed)
	if Input.is_action_pressed("ui_down"):
		apply_central_impulse(Vector2.DOWN * speed)
		
	if abs(get_linear_velocity().x) > speed or abs(get_linear_velocity().y) > speed:
		var new_speed = get_linear_velocity().normalized()
		new_speed *= speed
		set_linear_velocity(new_speed)

	if abs(get_linear_velocity().length()) < 149 and abs(get_linear_velocity().length()) > 0:
		set_linear_velocity(Vector2(0,0))

func _on_CharacterRig_body_shape_entered(body_id, body, body_shape, local_shape):
	#print(body.get_name())
	if "NectarBubble" in body.get_name():
		value += 1
		emit_signal("collectNectar", value)
		randomize()
		var randNum = rand_generate.randi_range(0, soundFxArray.size() - 1)
		sound.set_stream(soundFxArray[randNum])
		sound.play()
		body.queue_free()
		
	else:
		if "rock" in body.get_name():
			damage = 10
			health -= damage
			emit_signal("updateHealth", health, damage)
			

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
		
func _on_update_health(healthArg, amount):
	#print("in health f")
	health_over.value = healthArg
	if healthArg < maxHealth:
		health_over.visible = true
		health_under.visible = true
	
	if healthArg == 0:
		health_over.visible = false
		health_under.visible = false
		self.queue_free()
		get_tree().quit()
		
	update_tween.interpolate_property(health_under, "value", health_under.value, healthArg, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT,0.4)
	update_tween.start()
	
	_assign_color(health)
	

func _assign_color(health):
	if health < health_over.max_value * danger_zone:
		health_over.tint_progress = danger_color
	else:
		health_over.tint_progress = caution_color
		
		
func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health
		
		
		
