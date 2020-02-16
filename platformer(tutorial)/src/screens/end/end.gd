extends Control


func _ready():
	$Label.text = $Label.text % [playerdata.score, playerdata.deaths]
