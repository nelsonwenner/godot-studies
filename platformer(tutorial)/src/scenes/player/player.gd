extends Actor


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
	var new_velocity = linear_velocity
	new_velocity.x = speed.x * direction.x
	new_velocity.y += self.gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		new_velocity.y = speed.y * direction.y
	if is_jump_interrupted:
		new_velocity.y = 0.0
	return new_velocity
