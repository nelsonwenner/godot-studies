extends "res://src/scripts/Actor.gd"


export var stomp_impulce = 1600.0


func _on_stomp_detector_area_entered(area):
	self.velocity = calc_stomp_velocity(self.velocity, stomp_impulce)


func _on_enemy_detector_body_entered(body):
	die()


func _physics_process(delta):
	var is_jump_interrupted = Input.is_action_just_released("jump") and self.velocity.y < 0.0
	var direction = get_direction()
	self.velocity = calc_move_velocity(self.velocity, direction, self.speed, is_jump_interrupted)
	self.velocity = move_and_slide(self.velocity, self.FLOOR_NORMAL)


func get_direction():
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("jump") if is_on_floor() and Input.is_action_just_pressed("jump") else 0.0
	)
	
	
func calc_move_velocity(linear_velocity, direction, speed, is_jump_interrupted):
	var out = linear_velocity
	out.x = speed.x * direction.x
	if direction.y != 0.0: 
		out.y = speed.y * direction.y
	if is_jump_interrupted: 
		out.y = 0.0
	return out


func calc_stomp_velocity(linear_velocity, impulce):
	var out = linear_velocity
	out.y = -impulce
	return out
	

func die():
	playerdata.deaths += 1
	queue_free()
