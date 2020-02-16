extends Control


var paused = false setget set_paused


func _ready():
	playerdata.connect("score_updated", self, "update_interface")
	playerdata.connect("player_died", self, "_playerdata_player_died")
	update_interface()


func _unhandled_input(event):
	if event.is_action_pressed("pause"):
		self.paused = not self.paused
		get_tree().set_input_as_handled()

func _playerdata_player_died():
	self.paused = true
	$pause_overlay/title.text = "You died"

func update_interface():
	$score.text = "Score: %s" % playerdata.score
	

func set_paused(value):
	paused = value
	get_tree().paused = value
	$pause_overlay.visible = value
