extends Sprite

var meteors = texture.get_size()

var width = 1024
var height = 600

var meteor = {'width': 64/2, 'height': 64/2}
var velocity
var screen_size
var pos
var spin

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	pos = screen_size / 2
	velocity =  Vector2(rand_range(100, 300), 0).rotated(rand_range(0, 2*PI))
	spin = rand_range(-PI, PI)
	set_process(true)


func _process(delta):
	rotation += spin * delta
	
	pos += velocity * delta
	
	if pos.x >= width - meteor.width:
		pos.x = width - meteor.width
		velocity.x *= -1
		
	if pos.x <= meteor.width:
		pos.x = meteor.width
		velocity.x *= -1
	
	if pos.y >= height - meteor.height:
		pos.y = height - meteor.height
		velocity.y *= -1
		
	if pos.y <= meteor.height:
		pos.y = meteor.height
		velocity.y *= -1
		
	position = pos
