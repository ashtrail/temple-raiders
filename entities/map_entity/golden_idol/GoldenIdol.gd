extends Area2D

signal reached(player_id)

func _ready():
	add_to_group("golden_idols")
	$AnimationPlayer.play("idle")

func step():
	pass


func reset():
	pass
#	$Sprite.visible = true
#	$CollisionShape2D.set_deferred("disabled", false)


#func disable():
#	$Sprite.visible = false
#	$CollisionShape2D.set_deferred("disabled", true)


func _on_GoldenIdol_area_entered(area):
	if area.is_in_group('player'):
		emit_signal("reached", area.player_id)
#		disable()
