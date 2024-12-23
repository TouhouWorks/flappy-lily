extends Node2D

var speed := 80

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	position.x -= speed * delta



func _on_VisibilityNotifier2D_screen_exited():
	queue_free()




