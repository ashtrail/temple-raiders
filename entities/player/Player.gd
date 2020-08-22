extends Area2D

enum Direction {
	Right,
	Left,
	Down,
	Up
}

signal died(player_id)
signal curse_lifted(player_id)
signal moved(pos)
signal moving(start_pos, end_pos, duration)


export (int) var player_id = 1
export (float) var move_speed = 0.5

var moving = false

var inverted_controls = false

var curse_counter = 0

var facing_dir = Direction.Down
var next_facing_dir = Direction.Down

var velocity = Vector2()

func _ready():
	add_to_group("players")
	add_to_group("map_entities")


func reset():
	moving = false
	inverted_controls = false
	curse_counter = 0
	set_physics_process(true)



func get_input():
	velocity = Vector2()
	if not moving:
		if Input.is_action_pressed('up_%s' % player_id):
			velocity.y -= 1
			next_facing_dir = Direction.Up
		elif Input.is_action_pressed('down_%s' % player_id):
			velocity.y += 1
			next_facing_dir = Direction.Down
		if Input.is_action_pressed('left_%s' % player_id):
			velocity.x -= 1
			next_facing_dir = Direction.Left
		elif Input.is_action_pressed('right_%s' % player_id):
			velocity.x += 1
			next_facing_dir = Direction.Right
	velocity *= 24


func move(direction):
	moving = true
	$CollisionShape2D.set_deferred("disabled", true)
	if facing_dir != next_facing_dir:
		facing_dir = next_facing_dir
		$Sprite.frame = facing_dir
	var base_pos = position
	var target_pos = position + direction
#	emit_signal("moving", base_pos, target_pos, move_speed)
#	position = target_pos
#	print("position = ", position, "target pos", target_pos)
#	$Tween.interpolate_property($Sprite, "global_position", base_pos, target_pos,
#		move_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.interpolate_property(self, "position", base_pos, target_pos,
		move_speed, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	moving = false
	$CollisionShape2D.set_deferred("disabled", false)
	# redundant set to refresh area2d collisions ;_;
	position = target_pos
	emit_signal("moved", target_pos)


func bump(direction):
	moving = true
	if facing_dir != next_facing_dir:
		facing_dir = next_facing_dir
		$Sprite.frame = facing_dir
	var start_pos = position
	var end_pos = position + direction / 2
#	print("position = ", position, "target pos", target_pos)
	$Tween.interpolate_property(self, "position", start_pos, end_pos,
		move_speed / 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Tween.interpolate_property(self, "position", end_pos, start_pos,
		move_speed / 2, Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	moving = false


func _process(delta):
	get_input()


func _physics_process(delta):
#	var velocity = get_input()
	if velocity.length() == 0:
		return

	if inverted_controls:
		velocity = -velocity

#	print("move, changing casting dir")
	$RayCast2D.cast_to = velocity
	$RayCast2D.force_raycast_update()
	var collider = $RayCast2D.get_collider()
#	print("got collider = ", collider)
	if collider != null:
		bump(velocity)
	else:
		move(velocity)


func step():
	curse_counter = max(curse_counter - 1, 0)
	if inverted_controls and curse_counter == 0:
		inverted_controls = false
		print("cursed lifted")
		emit_signal("curse_lifted", player_id)

func invert_control(duration):
	inverted_controls = true
	curse_counter = duration


func die():
	moving = true
	set_physics_process(false)
	$Tween.stop_all()
	var timer = Timer.new()
	timer.wait_time = 0.2
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	emit_signal("died", player_id)
	print("ARG death")

