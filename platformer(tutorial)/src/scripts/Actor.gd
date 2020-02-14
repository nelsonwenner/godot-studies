extends KinematicBody2D

class_name Actor

# up: Vector2(0, -1)
const FLOOR_NORMAL = Vector2(0, -1)

export var speed = Vector2(800.0, 1000.0)
var velocity = Vector2(0, 0)
export var gravity = 4000.0
