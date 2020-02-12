extends Node

# scene instance
onready var enemy_patch = preload("res://scenes/enemy/enemy.tscn")

var score

func _ready():
	randomize()


func _new_game():
	score = 0
	$player.start($start_position.position)
	$start_timer.start()
	$hud.update_score(score)
	$hud.show_message("Get Ready")
	$music.play()
	
	
func _game_over():
	$score_timer.stop()
	$enemy_timer.stop()
	$hud.show_game_over()
	$music.stop()
	$death_sound.play()


func _on_start_timer():
	$enemy_timer.start()
	$score_timer.start()
	
	
func _on_score_timer():
	score += 1
	$hud.update_score(score)


func _on_enemy_timer():
	# Choose a random location on Path2D.
	$anemy_path/anemy_spawn_location.set_offset(randi())
	# Create a Mob instance and add it to the scene.
	var anemy = enemy_patch.instance()
	add_child(anemy)
	
	# Set the mob's direction perpendicular to the path direction.
	var direction = $anemy_path/anemy_spawn_location.rotation + PI / 2
	
	# Set the mob's position to a random location.
	anemy.position = $anemy_path/anemy_spawn_location.position
	
	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	
	anemy.rotation = direction
	
	# Set the velocity (speed & direction).
	anemy.linear_velocity = Vector2(rand_range(anemy.min_speed, anemy.max_speed), 0).rotated(direction)
	
