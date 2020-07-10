extends KinematicBody2D

const SPEED = 300

var motion = Vector2()

func _physics_process(delta):
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite.play("left")
	elif Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.play("right")
	else:
		if Input.is_action_pressed("ui_left"):
			motion.x = -SPEED
			$AnimatedSprite.play("idle_left")
		elif Input.is_action_pressed("ui_right"):
			motion.x = SPEED
			$AnimatedSprite.play("idle_right")
		else:
			motion.x = 0
			$AnimatedSprite.play("idle")
	move_and_slide(motion)
