extends "res://src/scripts/Actor.gd"


func _on_stomp_detect_body_entered(body):
	print("stomp -> collided")
	if body.global_position.y > $stomp_area.global_position.y:
		return
	die()


func _ready():
	set_physics_process(false)
	self.velocity.x = -self.speed.x
	

func _physics_process(delta):
	self.velocity.y = self.gravity * delta
	if is_on_wall():
		self.velocity.x *= -1.0
	self.velocity.y = move_and_slide(self.velocity, self.FLOOR_NORMAL).y


func die():
	queue_free()