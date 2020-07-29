extends KinematicBody2D

var velocity = Vector2()
var initial = false
var init_pos = Vector2()

func _ready():
	velocity.y = 300

func _physics_process(delta):
	$"AnimatedSprite".play()
	if !initial:
		initial = true
		init_pos = position.y
	if position.y > init_pos + 500:
		queue_free()
	move_and_slide(velocity)

func _on_Area2D_area_entered(area):
	queue_free()
