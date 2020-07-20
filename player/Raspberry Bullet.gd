extends KinematicBody2D

var velocity = Vector2()

func _ready():
	velocity.y = -400

func _physics_process(delta):
	if position.y > 10000:
		queue_free()
	move_and_slide(velocity)

