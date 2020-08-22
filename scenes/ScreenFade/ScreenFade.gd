extends CanvasLayer

func flash(color, text, fade_duration):
	$Visuals/ColorRect.color = color
	$Visuals/Label.text = text
	$Visuals.show()
#	var timer = Timer.new()
#	timer.wait_time = show_duration
#	add_child(timer)
#	timer.start()
#	yield(timer, "timeout")
	$Tween.interpolate_property($Visuals, "modulate.a", 1, 0, fade_duration,
		Tween.TRANS_EXPO , Tween.EASE_OUT)
	$Tween.start()
	yield($Tween, "tween_completed")
	$Visuals.hide()
