extends Camera2D

var target = null

func init(player):
	target = player
#	target = player.get_node("Sprite")
#	print("target = ", target)
#	position.y = player.position.y
#	player.connect("moving", self, "_on_Player_moving")

#func _on_Player_moving(start_pos, end_pos, duration):
#	print("update camera")
#	$Tween.interpolate_property(self, "position:y", start_pos.y, end_pos.y, duration,
#		Tween.TRANS_CUBIC, Tween.EASE_IN_OUT)
#	$Tween.start()
##	position.y = pos.y

func _physics_process(delta):
#	return
	if target:
		position.y = target.global_position.y
