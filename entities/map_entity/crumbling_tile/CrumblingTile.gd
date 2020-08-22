extends Area2D

enum State {
	Normal,
	CrumbleStart,
	CrumbleMid,
	Crumbled
}

export (State) var state = State.Normal

export (Texture) var normal_text = load("res://entities/map_entity/crumbling_tile/CrumbleTileV2.png")
export (Texture) var bloody_text = load("res://entities/map_entity/crumbling_tile/BonesCrumbleTileV2.png")


var is_blocking = false

var start_crumbling = false

func _ready():
#	add_to_group("map_entities")
	add_to_group("crumbling_tiles")
	$Sprite.texture = normal_text



func set_state(new_state):
	state = new_state
	$Sprite.frame = new_state


func step():
	if start_crumbling == true and state == State.Normal:
		set_state(State.CrumbleStart)
	else:
		if state == State.Normal or state == State.Crumbled:
			return
		set_state(state + 1)
		if state == State.Crumbled:
			for player in get_overlapping_areas():
				$Sprite.texture = bloody_text
				player.die()


func _on_CrumblingTile_area_entered(area):
	if state == State.Normal:
		start_crumbling = true
#		set_state(State.CrumbleStart)
	elif state == State.Crumbled:
		area.die()
		$Sprite.texture = bloody_text



func reset():
	start_crumbling = false
	set_state(State.Normal)

