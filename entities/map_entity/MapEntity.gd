extends Area2D

export (bool) var is_blocking
export (bool) var is_consumable
export (bool) var is_deadly

func _ready():
	add_to_group("map_entities")

func step():
	pass

func consume():
	pass

func reset():
	pass
