extends KinematicBody2D

var velocity = Vector2()
var camera_pos = Vector2()

func _ready():
	velocity.y = -400
	camera_pos = get_parent().get_parent().get_node("Camera").position

func _physics_process(delta):
	if position.y < camera_pos.y - 4000:
		queue_free()
	move_and_slide(velocity)
