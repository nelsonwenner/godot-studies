extends "res://src/scripts/Actor.gd"


export var stomp_impulce = 1600.0


func _on_stomp_detector_area_entered(area):
	self.velocity = calc_stomp_velocity(self.velocity, stomp_impulce)


func _on_enemy_detector_body_entered(body):
	print("enemy -> detect")
	queue_free()


func _physics_process(delta):
	var is_jump_interrupted = Input.is_action_just_released("jump") and self.velocity.y < 0.0
	var direction = get_direction()
	self.velocity = calc_move_velocity(self.velocity, direction, self.speed, is_jump_interrupted)
	self.velocity = move_and_slide(self.velocity, self.FLOOR_NORMAL)


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)
	
	
func calc_move_velocity(linear_velocity, direction, speed, is_jump_interrupted):
	var out = linear_velocity
	out.x = speed.x * direction.x
	out.y += self.gravity * get_physics_process_delta_time()
	if direction.y == -1.0: 
		out.y = speed.y * direction.y
	if is_jump_interrupted: 
		out.y = 0.0
	return out
	
	
func calc_stomp_velocity(linear_velocity, impulce):
	var out = linear_velocity
	out.y = -impulce
	return out
	
	
func calculate_stomp_velocity(linear_velocity, stomp_impulse):
	var stomp_jump = -self.speed.y if Input.is_action_pressed("jump") else -stomp_impulse
	return Vector2(linear_velocity.x, stomp_jump)
