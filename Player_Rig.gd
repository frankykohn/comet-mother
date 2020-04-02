extends RigidBody2D

var velocity = Vector2()
var noKeyPress = false;
var look_direction = Vector2(1,0)

export (int) var speed = 150

func _ready():
	set_contact_monitor(true)
	connect("body_shape_entered", self, "_on_CharacterRig_body_shape_entered")
	
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
	if "PhysParticle" in body.get_name():
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

	
	
	
	
