extends RigidBody2D

signal end_game
signal collision_happened
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var onGame := false
var isUp := false
var gameEnd := false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/mainBody.playing = true
	$Area2D/mainBody.animation = "fly"

func change_stauts(stauts:int):
	match stauts:
		1:
			$Area2D/leg.position.x = -10
			$Area2D/leg.position.y = 51
			$Area2D/leg.rotation_degrees = 0
		2:
			$Area2D/leg.position.x = 5
			$Area2D/leg.position.y = 51
			$Area2D/leg.rotation_degrees = 20
		3:
			$Area2D/mainBody.stop()
			$Area2D/mainBody.set_deferred("frame",0)
			$Area2D/leg.position.x = 0
			$Area2D/leg.position.y = 61
			$Area2D/leg.rotation_degrees = -60

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if onGame :
		if Input.is_key_pressed(KEY_SPACE) or Input.is_mouse_button_pressed(BUTTON_LEFT):
			change_stauts(2)
			apply_central_impulse(Vector2(0,-20))
			isUp = false
		else:
			change_stauts(1)
	else:
		if $Area2D.rotation_degrees > -90:
			$Area2D.rotate(-0.10*PI*delta)
	if position.y > 1000 and !gameEnd:
		emit_signal("end_game")
		gameEnd = true
		hide()
		position.y = 100
		set_deferred("sleeping",true)


func _on_Area2D_area_entered(area):
	onGame = false
	change_stauts(3)
	$Area2D/CollisionShape2D.set_deferred("disabled", true)
	emit_signal("collision_happened")
	$hitSound.play()
