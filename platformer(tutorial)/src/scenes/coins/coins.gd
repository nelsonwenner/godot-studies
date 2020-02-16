extends Area2D


var score = 100


func _on_coins_body_entered(body):
	picked()


func _ready():
	$AnimationPlayer.play("bounsing")
	

func picked():
	playerdata.score += score
	$AnimationPlayer.play("fade_out")
