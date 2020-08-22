extends Area2D

export (bool) var left = false setget set_dir
export (int) var fire_rate = 3

var FireBall = load("res://entities/map_entity/fire_ball/FireBall.tscn")

var is_blocking = true

var fire_delay = 0

func _ready():
	add_to_group("fire_spitter")
#	if left:
#		scale = Vector2(-1, 1)

func set_dir(new_value):
	left = new_value
	if left:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = true


func shoot():
	var fire_ball = FireBall.instance()
#	var facing_left = scale == Vector2(-1, 1)
	if left:
		fire_ball.position = position + Vector2(-1, 0) * 24
		fire_ball.init(false)
	else:
		fire_ball.position = position + Vector2(1, 0) * 24
		fire_ball.init(true)
	get_parent().add_child(fire_ball)
	fire_delay = fire_rate
#	reset()

func step():
	fire_delay -= 1

	# telegraph shot
	if fire_delay - 1 == 0:
		$Sprite.frame = 1
	else:
		$Sprite.frame = 0
	
	if fire_delay == 0:
		shoot()

func reset():
	fire_delay = 2


func _on_FireBall_area_entered(area):
	if area.is_in_group('player'):
		area.die()
	reset()
