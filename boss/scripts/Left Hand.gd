extends KinematicBody2D

var left_hand_lives = 100
var animation = "left_hand"
var dead = false
var utensils = "spoon"
var motion = Vector2()
var sound_played = false

func _physics_process(delta):
	$"Hand".play(animation)
	$Utensils.play(utensils)
	if !dead:
		if position.y < 250:
			motion.y = 300
		elif position.y > 550:
			motion.y = -300
		if left_hand_lives == 66:
			utensils = "fork"
		elif left_hand_lives == 33:
			utensils = "knife"
	else:
		motion.y = 0
		$Utensils.visible = false
	move_and_slide(motion)

func _on_Area2D_area_entered(area):
	if left_hand_lives > 1:
		left_hand_lives -= 1
	else:
		dead = true
		animation = "left_hand_dead"
		if !sound_played:
			$"Hand Death Sound".play()
			sound_played = true
