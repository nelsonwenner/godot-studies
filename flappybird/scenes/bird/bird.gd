extends Area2D

signal start_flight
signal death

var FLIGHT_CEILING = 28
var GRAVITY = 8
var FLY_UPWARD_VELOCITY = -225
var MAX_DOWNWARD_VELOCITY = 300
var ROTATION_VELOCITY = 250
var FLYING_ROTATION = -45
var DIVING_ROTATION = 90

var vertical_velocity = 0
var should_rotate = false

var ANIMATION_FLAP_SPEED = 3
var ANIMATION_FLY_SPEED = 2

enum State {AUTO_PILOT, PLAYING, CRASHING, CRASHED}

var current_state = State.AUTO_PILOT

var screen_size

func _ready():
	
	# Get the screen size
	screen_size = get_viewport_rect().size
	
	# Ensure the player does not have control on creation
	set_player_state(State.AUTO_PILOT)

func _physics_process(delta):
	
	# Start the phase of player control if flight is triggered during the passive phase
	if current_state == State.AUTO_PILOT and Input.is_action_just_pressed("fly"):
		emit_signal("start_flight")
		set_player_state(State.PLAYING)
		
	# Apply the actual physics depending on the state
	match current_state:
		State.PLAYING:
			
			# Apply the impact of gravity
			vertical_velocity += GRAVITY
			
			# Check if the player is inputting a flight command
			if Input.is_action_just_pressed("fly"):
				
				# Play the flap animation and apply flight changes
				$AnimationPlayer.play("flying", -1, ANIMATION_FLAP_SPEED)
				vertical_velocity = FLY_UPWARD_VELOCITY
				should_rotate = false
				rotation_degrees = FLYING_ROTATION
				$RotationBeginTimout.start()
				
			# Actually apply the physics
			position.y += vertical_velocity * delta
			position.y = clip(position.y, FLIGHT_CEILING, screen_size.y)
			
			if should_rotate:
				rotation_degrees = clip(rotation_degrees + ROTATION_VELOCITY * delta, FLYING_ROTATION, DIVING_ROTATION)

func set_player_state(state):
	match state:
		State.AUTO_PILOT:
			
			# Take away the player control
			current_state = State.AUTO_PILOT
			
			# Reset other control properties
			vertical_velocity = 0
			
			# Set other control properties
			should_rotate = true
			
			# Reset the position and rotation of the player
			position.y = screen_size.y / 2
			position.x = screen_size.x / 3
			rotation_degrees = 0
			
			# Passively play the flying animation on loop
			$AnimatedSprite.stop()
			$AnimatedSprite.set_animation("fly")
			$AnimationPlayer.get_animation("flying").loop = true
			$AnimationPlayer.play("flying", -1, ANIMATION_FLY_SPEED)

		State.PLAYING:
			
			# Give the player control of the character
			current_state = State.PLAYING
	
			# Reset the flying animation and stop it as it will only trigger on fly command
			$AnimatedSprite.stop()
			$AnimatedSprite.set_animation("fly")
			$AnimationPlayer.stop(false)
			$AnimationPlayer.get_animation("flying").loop = false

func _on_RotationBeginTimout_timeout():
	# Time to start the rotation as it as been sufficient time after the flap
	should_rotate = true

func clip(value, minimum, maximum):
	if value < minimum: return minimum
	if value > maximum: return maximum
	return value
