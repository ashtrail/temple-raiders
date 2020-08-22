tool
extends Node2D

export (int) var world_id = 1
export (int) var width = 5
export (int) var height = -20
export (int) var cell_size = 24
export (Texture) var base_tile_texture = null

onready var pixel_width = width * cell_size
onready var pixel_height = height * cell_size

func _ready():
	$Player.player_id = world_id
	randomize()
	reset()
#	get_tree().call_group("map_entities", "reset")


func _draw():
	var color = Color.black
	var line_width = 1.2

	# draw tiles
	for x in range(0, width):
		for y in range(-0, height, -1):
			var odd_height = y % 2 != 0
			var odd_width = x % 2 != 0
			if odd_height != odd_width:
				draw_texture(base_tile_texture, Vector2(x, y) * cell_size)
			else:
				draw_texture(base_tile_texture, Vector2(x, y) * cell_size, Color(.6, .5, .7))
#				draw_texture(base_tile_texture, Vector2(x, y) * cell_size, Color(.8, 0.6, 1))

#	var color = Color.black
#	var line_width = 1.2
#
#	# draw tiles
#	for x in range(0, width):
#		for y in range(-0, height, -1):
#			draw_texture(base_tile_texture, Vector2(x, y) * cell_size)


func reset():
	$Player.position = $PlayerSpawn.position
	var entities = get_tree().get_nodes_in_group("map_entities")
	for e in entities:
		if is_a_parent_of(e):
			e.reset()
#	 is_a_parent_of( Node node ) 
#	get_children().call_group("map_entities", "reset")


func _on_Player_died(player_id):
	print("wesh ?")
	reset()
