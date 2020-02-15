extends KinematicBody2D

class_name Actor

# up: Vector2(0, -1)
const FLOOR_NORMAL = Vector2(0, -1)

export var speed = Vector2(400.0, 500.0)
var velocity = Vector2(0, 0)
export var gravity = 3500.0


func _physics_process(delta):
	velocity.y += gravity * delta
