extends Area2D


export var next_scene: PackedScene


func _on_portal_body_entered(body):
	teleport()
	

func _get_configuration_warning():
	return "The next scene property can't be empty" if not next_scene else ""


func teleport():
	$AnimationPlayer.play("fade_in")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene_to(next_scene)
