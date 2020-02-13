extends Node

onready var meteors = preload("res://scenes/meteors/meteor.tscn")


func _ready():
	for i in range(50):
		var meteor = meteors.instance()
		add_child(meteor)


func _process(delta):
	pass
