extends CanvasLayer

signal start_game

func show_message(text):
	$message_label.text = text
	$message_label.show()
	$message_timer.start()
	
func show_game_over():
	show_message("Game Over")

	yield($message_timer, "timeout")
	
	$message_label.text = "Dodge the\nCreeps!"
	$message_label.show()

	yield(get_tree().create_timer(1), "timeout")

	$start_button.show()
	
func update_score(score):
	$score_label.text = str(score)

func _on_message_timer_timeout():
	$message_label.hide()

func _on_start_button_pressed():
	$start_button.hide()
	emit_signal("start_game")
	
