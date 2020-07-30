extends KinematicBody2D

var right_hand_lives = 100
var animation = "right_hand"
var dead = false
var motion = Vector2()

var counter = 0

var projectile
var projectile_tip
var level

var sound_played = false

func _ready():
	projectile = load("res://boss/Boss Projectile.tscn")
	projectile_tip = load("res://boss/Boss Projectile Tip.tscn")
	level = get_parent()

func _physics_process(delta):
	$"AnimatedSprite".play(animation)
	if !dead:
		if position.x < 280:
			motion.x = 300
		elif position.x > 500:
			motion.x = -300
		if counter == 200:
			shoot_tip()
			counter += 1
		elif counter > 205 and counter < 240:
			shoot()
			if counter == 235:
				counter = 0
			else:
				counter += 1
		else:
			counter += 1
	else:
		motion.x = 0
	move_and_slide(motion)

func _on_Area2D_area_entered(area):
	if right_hand_lives > 1:
		right_hand_lives -= 1
	else:
		dead = true
		animation = "right_hand_dead"
		if !sound_played:
			$"Hand Death Sound".play()
			sound_played = true

func shoot():
	var bullet = projectile.instance()
	add_child(bullet)
	level.move_child(bullet, 0)

func shoot_tip():
	var bullet = projectile_tip.instance()
	add_child(bullet)
	level.move_child(bullet, 0)
