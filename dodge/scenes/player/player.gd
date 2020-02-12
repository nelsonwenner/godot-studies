extends Area2D

signal hit

var screen_size
var speed = 400

func _ready():
	self.screen_size = get_viewport_rect().size
	hide()


func _process(delta):
	
	var velocity = Vector2(0, 0)
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
		
	position += velocity * delta
	position.x = self.clip(position.x, 0, screen_size.x)
	position.y = self.clip(position.y, 0, screen_size.y)
	
	self.choose_animation(velocity)


#in contact with a body, collision
func _on_player_body_entered(body):
	hide()
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true)


func choose_animation(velocity):
	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func clip(value, minimum, maximum):
	if value < minimum: return minimum
	if value > maximum: return maximum
	return value
