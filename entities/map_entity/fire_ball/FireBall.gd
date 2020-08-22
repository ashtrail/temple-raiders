extends Area2D

var Ashes = load("res://entities/map_entity/fire_ball/Ashes.tscn")

var is_blocking = false

var direction = Vector2(24, 0)

func _ready():
	# add_to_group("map_entities")
	add_to_group("fire_ball")


func init(going_right):
	if not going_right:
		direction = -direction
		$Sprite.flip_h = true

func step():
	position += direction

func reset():
	call_deferred("queue_free")


func _on_FireBall_area_entered(area):
	if area.is_in_group('player'):
		var ashes = Ashes.instance()
		ashes.position = position
		get_parent().add_child(ashes)
		area.die()
	reset()
