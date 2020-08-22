extends Area2D

enum State {
	Blue,
	Red,
	Spikes
}

export (State) var state = State.Blue

export (Texture) var normal_text = load("res://entities/map_entity/disco_tile/DiscoTileV3.png")
export (Texture) var bloody_text = load("res://entities/map_entity/disco_tile/BloodyDiscoTileV3.png")


var is_blocking = false

func _ready():
	# add_to_group("map_entities")
	add_to_group("disco_tiles")
	$Sprite.texture = normal_text


func set_state(new_state):
	state = new_state
	$Sprite.frame = new_state


func step():
	set_state((state + 1) % 3)
	if state == State.Spikes:
		for player in get_overlapping_areas():
			$Sprite.texture = bloody_text
			player.die()




func _on_DiscoTile_area_entered(area):
	if state == State.Spikes:
		$Sprite.texture = bloody_text
		area.die()


func reset():
	set_state(randi() % 3)

