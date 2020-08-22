extends Node2D

var confirm1 = false
var confirm2 = false

#func _ready():
#	$UI/Winner.text = "Player %s wins !" % Global.winner_id

func _process(delta):
	if Input.is_action_just_pressed("up_1"):
		confirm1 = true
	if Input.is_action_just_pressed("up_2"):
		confirm2 = true
	if confirm1 and confirm2:
		get_tree().change_scene("res://scenes/Main.tscn")
