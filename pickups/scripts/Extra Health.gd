extends KinematicBody2D

var velocity = Vector2()

func _ready():
	velocity.y = 100

func _physics_process(delta):
	move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	queue_free()
