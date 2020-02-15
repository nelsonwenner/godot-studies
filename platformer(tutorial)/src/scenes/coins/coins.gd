extends Area2D


func _on_coins_body_entered(body):
	$AnimationPlayer.play("fade_out")


func _ready():
	$AnimationPlayer.play("bounsing")
	

func _process(delta):
	pass
