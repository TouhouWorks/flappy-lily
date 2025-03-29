extends Node

export(PackedScene) var obstalce_scene
export(PackedScene) var ground_scene

var score := 0
var mute := false
var mutePressed := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$LilyWhite.sleeping = true
	$LilyWhite.hide()

func new_game():
	score = 0
	$ScoreDisplay/Label.text = str(0)
	$LilyWhite.position = $StartPosition.position
	$LilyWhite/Area2D.rotation_degrees = 0
	$LilyWhite.onGame = true
	$LilyWhite.gameEnd = false
	$LilyWhite/Area2D/mainBody.play()
	get_tree().call_group("obstacles","queue_free")
	get_tree().call_group("grounds","queue_free")
	for i in range(4):
		gen_ground(i*280)
	gen_obstalce(1120)
	$ScoreTimer.start()
	$LilyWhite.set_deferred("sleeping",false)
	$LilyWhite/Area2D/CollisionShape2D.disabled = false
	$LilyWhite.show()
	$Music.play()
	$LilyWhite.onGame = true
	
func gen_ground(pos_x:int):
	var ground = ground_scene.instance()
	ground.position.x = pos_x
	add_child(ground)

func gen_obstalce(pos_x:int):
	var obstalce = obstalce_scene.instance()
	obstalce.position.x = pos_x 
	add_child(obstalce)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

	
func terrain_go_out_window(node):
	var childernObstacle:Array 
	for i in get_children():
		if i.name.match("*Obstacle*"):
			childernObstacle.append(i)
	var lastNode
	if len(childernObstacle) == 0:
		lastNode = get_node("@Ground@4")
	else:
		lastNode = childernObstacle[len(childernObstacle)-1]
	gen_obstalce(lastNode.position.x+280)


func _on_LilyWhite_end_game():
	$ScoreTimer.stop()
	$HUD/Button.text = "try again"
	$HUD/score.text = "your last score : "+str(score)
	$HUD.show()


func _on_ScoreTimer_timeout():
	score += 1
	$ScoreDisplay/Label.text = str(score)


func _on_LilyWhite_collision_happened():
	$Music.stop()

func _on_MuteButton_pressed():
	$Mute/MuteButton.release_focus()
	if !mute :
		$Mute/MuteButton.texture_normal = load("res://asset/mute.png")
	else:
		$Mute/MuteButton.texture_normal = load("res://asset/cancelMute.png")
	if mute == true :
		mute = false
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, mute)
		mutePressed = true
	$Mute/kickSound.play()
	

func _on_kickSound_finished():
	if mute == false && mutePressed == false:
		mute = true
		var bus_idx = AudioServer.get_bus_index("Master")
		AudioServer.set_bus_mute(bus_idx, mute)
	mutePressed = false
