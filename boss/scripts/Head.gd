extends KinematicBody2D

var head_lives = 200
var animation = "head"

var left_hand_lives
var right_hand_lives

var counter = 200

var level
var projectile

func _ready():
	left_hand_lives = get_parent().get_node("Left Hand")
	right_hand_lives = get_parent().get_node("Right Hand")
	level = get_parent()
	projectile = load("res://boss/Vomit.tscn")

func _physics_process(delta):
	$AnimatedSprite.play(animation)
	if head_lives < 100:
		if counter == 300:
			$Vomit.play()
			animation = "vomit"
			counter = 0
		else:
			counter += 1

func _on_Area2D_area_entered(area):
	if left_hand_lives.left_hand_lives == 1 and right_hand_lives.right_hand_lives == 1:
		if head_lives > 100:
			head_lives -= 1
		elif animation != "head_injured":
			animation = "head_injured"
			head_lives -= 1
			$"Hurt Sound".play()
		else:
			head_lives -= 1
		if head_lives == 1:
			$"Dead Sound".play()

func _on_AnimatedSprite_animation_finished():
	if animation == "vomit":
		animation = "head_injured"
		shoot()

func shoot():
	var bullet = projectile.instance()
	add_child(bullet)
	level.move_child(bullet, 0)

func _on_Dead_Sound_finished():
	get_tree().change_scene("res://levelpassed_screen/Level Passed Screen.tscn")
