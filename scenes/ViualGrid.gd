tool
extends Node2D

onready var temple = get_parent()

func _draw():
	return
	var color = Color(0, 0, 0, 0.5)
	var line_width = 1

	# draw grid
	for x in range(0, temple.width + 1):
		var pixel_x = x *  temple.cell_size
		draw_line(Vector2(pixel_x, temple.cell_size),
				Vector2(pixel_x, temple.pixel_height), color, line_width)
	for y in range(1, temple.height - 1, -1):
#		print("y = ", y)
		var pixel_y = y *  temple.cell_size
		draw_line(Vector2(0, pixel_y),
				Vector2(temple.pixel_width, pixel_y), color, line_width)
