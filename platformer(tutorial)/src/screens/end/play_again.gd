extends Button


func _on_play_again_button_up():
	playerdata.score = 0
	get_tree().change_scene("res://src/main/main.tscn")
