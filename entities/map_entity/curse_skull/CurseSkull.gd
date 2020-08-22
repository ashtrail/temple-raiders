extends Area2D

signal triggered(player_id, duration)

export (int) var curse_duration = 10


func _ready():
	add_to_group("curse_skulls")
	$AnimationPlayer.play("idle")

func step():
	pass

func reset():
	$Sprite.visible = true
	$CollisionShape2D.set_deferred("disabled", false)


func disable():
	$Sprite.visible = false
	$CollisionShape2D.set_deferred("disabled", true)


func _on_CurseSkull_area_entered(area):
	if area.is_in_group('player'):
		emit_signal("triggered", area.player_id, curse_duration)
		disable()
