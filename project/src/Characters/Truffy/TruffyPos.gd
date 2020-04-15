extends Position2D

export var speed = 200
export var steer_force = 100.0

var velocity = Vector2.ZERO
var acceleration = Vector2.ZERO
var target = null
var aphid_01_group
var aphid_03_group
var aphid_04_group
var player
var searchGroup

func _ready():
	var temp = get_tree().get_nodes_in_group("player")
	player = temp[0]
	#print(player.get_name())
	
func _process(delta):
	if Input.is_key_pressed(KEY_J):
		aphid_01_group = get_tree().get_nodes_in_group("aphid_01")
		searchGroup = aphid_01_group
		target = get_nearest(aphid_01_group)
	if Input.is_key_pressed(KEY_K):
		aphid_03_group = get_tree().get_nodes_in_group("aphid_03")
		searchGroup = aphid_03_group
		target = get_nearest(aphid_03_group)
	if Input.is_key_pressed(KEY_L):
		aphid_04_group = get_tree().get_nodes_in_group("aphid_04")
		searchGroup = aphid_04_group
		target = get_nearest(aphid_04_group)
	
func seek():
	var desired = Vector2.ZERO
	var steer = Vector2.ZERO
	if target:
		desired = (target.global_position - global_position).normalized() * speed #using local coordinates
		steer = (desired - velocity).normalized() * steer_force
	return steer
	
func _physics_process(delta):
	var vectorToPlayer = player.global_position - global_position
	var VelocityToPlayer = vectorToPlayer.normalized() * speed
	if target:
		var vectorToGoal = target.global_position - global_position
		if abs(vectorToGoal.length()) < 600 and abs(vectorToPlayer.length()) < 300:
			acceleration += seek() #go to target
			transform_stuff(delta)
	
		elif abs(vectorToGoal.length()) < 600 and abs(vectorToPlayer.length()) > 300:
			var steer = (VelocityToPlayer - velocity).normalized() * steer_force
			acceleration += steer #go to player
			transform_stuff(delta)
		
		elif abs(vectorToGoal.length()) > 600 and abs(vectorToPlayer.length()) < 300:
			target = get_nearest(searchGroup)
			acceleration += seek() #go to target
			transform_stuff(delta)
		else: 
			var steer = (VelocityToPlayer - velocity).normalized() * steer_force
			acceleration += steer #go to player
			transform_stuff(delta)
	else:
		#if abs(vectorToPlayer.length()) > 100:
			var steer = (VelocityToPlayer - velocity).normalized() * steer_force
			acceleration += steer #go to player
			transform_stuff(delta)
		
func get_nearest(desired):
	var nearest_object = desired[0]
	for object in desired:
		if object.global_position.distance_to(player.global_position) < nearest_object.global_position.distance_to(player.global_position):
			nearest_object = object
	return nearest_object
			
func transform_stuff(delta):
	velocity += acceleration * delta
	velocity = velocity.clamped(speed)
	rotation = velocity.angle() 
	position += velocity * delta	
	
	
