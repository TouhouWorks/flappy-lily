extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var random = RandomNumberGenerator.new()
	random.randomize()
	var textrueUp = load("res://asset/mushroom/mushroom"+str(random.randi_range(0,9))+".png")
	var textureDown = load("res://asset/mushroom/mushroom"+str(random.randi_range(0,9))+".png")
	var ramdomPosition = random.randi_range(0,4)*70
	$down/mushroom.texture = textrueUp
	$up/mushroom.texture = textureDown
	$down/mushroom.position.y = 295 - ramdomPosition
	$down/stemCS2.position.y = 295 - ramdomPosition
	$down/shroomCS2.position.y = -160 - ramdomPosition
	$up.position.y = -85 - ramdomPosition


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = 80
	position.x -= speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
