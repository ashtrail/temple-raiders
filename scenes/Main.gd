extends Node2D

onready var viewport1 = $Viewports/ViewportContainer1/Viewport1
onready var viewport2 = $Viewports/ViewportContainer2/Viewport2

onready var camera1 = $Viewports/ViewportContainer1/Viewport1/Camera1
onready var camera2 = $Viewports/ViewportContainer2/Viewport2/Camera2

onready var world1 = $Viewports/ViewportContainer1/Viewport1/Temple1
onready var world2 = $Viewports/ViewportContainer2/Viewport2/Temple2


func _ready():
	camera1.init(world1.get_node("Player"))
	camera2.init(world2.get_node("Player"))
#	camera1.target = 
#	camera2.target = world2.get_node("Player")
#	set_camera_limits()
	# connections
	for player in get_tree().get_nodes_in_group("players"):
		player.connect("curse_lifted", self, "_on_Player_curse_lifted")
		player.connect("died", self, "_on_Player_died")
	for skull in get_tree().get_nodes_in_group("curse_skulls"):
		skull.connect("triggered", self, "_on_CurseSkull_triggered")
	for idol in get_tree().get_nodes_in_group("golden_idols"):
		idol.connect("reached", self, "_on_GoldenIdol_reached")


func set_camera_limits():
	for cam in [camera1, camera2]:
		cam.limit_left = 0
		cam.limit_right = world1.width * world1.cell_size


func _on_CurseSkull_triggered(player_id, duration):
	var victim_id = 1 if player_id == 2 else 2
#	var victim_id = player_id
	var screen_fader
	if victim_id == 1:
		screen_fader = $Viewports/ViewportContainer1/Viewport1/ScreenFade1
	else:
		screen_fader = $Viewports/ViewportContainer2/Viewport2/ScreenFade2
	screen_fader.flash(Color.black, "You have been cursed !", 0.3)
	for player in get_tree().get_nodes_in_group("player"):
		if player.player_id == victim_id:
			player.invert_control(duration)


func _on_Player_curse_lifted(player_id):
#	print("visuals cursed lifted")
	var screen_fader
	if player_id == 1:
		screen_fader = $Viewports/ViewportContainer1/Viewport1/ScreenFade1
	else:
		screen_fader = $Viewports/ViewportContainer2/Viewport2/ScreenFade2
	screen_fader.flash(Color.white, "The curse has been lifted !", 0.3)


func _on_Player_died(player_id):
#	print("visuals cursed lifted")
	var screen_fader
	if player_id == 1:
		screen_fader = $Viewports/ViewportContainer1/Viewport1/ScreenFade1
	else:
		screen_fader = $Viewports/ViewportContainer2/Viewport2/ScreenFade2
	screen_fader.flash(Color.red, "", 0.3)


func _on_StepTimer_timeout():
	get_tree().call_group("map_entities", "step")


func _on_GoldenIdol_reached(player_id):
	Global.winner_id = player_id
	print("Player %s wins !" % player_id)
	get_tree().change_scene("res://scenes/end_screen/EndScreen.tscn")
