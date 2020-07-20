extends KinematicBody2D

var velocity = Vector2()

func _ready():
	velocity.y = 300

func _physics_process(delta):
	$"AnimatedSprite".play()
	if position.y > 10000:
		queue_free()
	move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	queue_free()
