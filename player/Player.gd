extends KinematicBody2D

const SPEED = 400
const REFINED_SPEED = 200

var motion = Vector2()

var health = 4
var lives

var idle
var left
var right
var idle_left
var idle_right

var camera
var projectile
var bb_projectile
var rasp_projectile
var lem_projectile_small
var lem_projectile_med
var lem_projectile_big
var lem = 0
var level

var fire_rate = 0
var bbfire_rate = 0
var lemfire_rate = 0

var health_green
var health_yellow
var health_orange
var health_red

func _ready():
	motion.y = -100
	camera = get_parent().get_node("Camera")
	projectile = load("res://player/Carrot Bullet.tscn")
	bb_projectile = load("res://player/Blueberry Bullet.tscn")
	rasp_projectile = load("res://player/Raspberry Bullet.tscn")
	lem_projectile_small = load("res://player/Lemon Bullet Small.tscn")
	lem_projectile_med = load("res://player/Lemon Bullet Med.tscn")
	lem_projectile_big = load("res://player/Lemon Bullet Big.tscn")
	level = get_parent()
	health_green = get_parent().get_node("Camera/Health/Green")
	health_yellow = get_parent().get_node("Camera/Health/Yellow")
	health_orange = get_parent().get_node("Camera/Health/Orange")
	health_red = get_parent().get_node("Camera/Health/Red")
	lives = get_node("/root/PlayerVariables")
	idle = "idle"
	left = "left"
	right = "right"
	idle_left = "idle_left"
	idle_right = "idle_right"

func _physics_process(delta):
	print(position)
	if Input.is_action_just_pressed("ui_left"):
		$AnimatedSprite.play(left)
	elif Input.is_action_just_pressed("ui_right"):
		$AnimatedSprite.play(right)
	else:
		if Input.is_action_pressed("ui_x"):
			if Input.is_action_pressed("ui_left"):
				if position.x > 100:
					motion.x = -REFINED_SPEED
					$AnimatedSprite.play(idle_left)
				else:
					motion.x = 0
			elif Input.is_action_pressed("ui_right"):
				if position.x < 924:
					motion.x = REFINED_SPEED
					$AnimatedSprite.play(idle_right)
				else:
					motion.x = 0
			else:
				motion.x = 0
				$AnimatedSprite.play(idle)
		else:
			if Input.is_action_pressed("ui_left"):
				if position.x > 100:
					motion.x = -SPEED
					$AnimatedSprite.play(idle_left)
				else:
					motion.x = 0
			elif Input.is_action_pressed("ui_right"):
				if position.x < 924:
					motion.x = SPEED
					$AnimatedSprite.play(idle_right)
				else:
					motion.x = 0
			else:
				motion.x = 0
				$AnimatedSprite.play(idle)
	if Input.is_action_pressed("ui_up"):
		if position.y > (camera.position.y - 250):
			motion.y = -SPEED
		else:
			motion.y = -100
	elif Input.is_action_pressed("ui_down"):
		if position.y < (camera.position.y + 200):
			motion.y = SPEED
		else:
			motion.y = -100
	else:
		motion.y = -100
	if Input.is_action_pressed("ui_z"):
		if idle == "bb_idle":
			if bbfire_rate == 0:
				bb_shoot()
				shoot()
				bbfire_rate = 5
		elif idle == "rasp_idle":
			rasp_shoot()
		elif idle == "lem_idle":
			if lemfire_rate == 0:
				if lem == 0:
					lem_shoot_small()
					lem = 1
				elif lem == 1:
					lem_shoot_med()
					lem = 2
				elif lem == 2:
					lem_shoot_big()
					lem = 3
				elif lem == 3:
					lem_shoot_med()
					lem = 4
				elif lem == 4:
					lem_shoot_small()
					lem = 0
				lemfire_rate = 5
		else:
			if fire_rate == 0:
				shoot()
				fire_rate = 10
	move_and_slide(motion)
	if lives.lives == 0:
		get_tree().change_scene("res://gameover_screen/Game Over.tscn")
	if health == 0:
		lives.lives -= 1
		get_tree().reload_current_scene()
	if fire_rate > 0:
		fire_rate -= 1
	if bbfire_rate > 0:
		bbfire_rate -= 1
	if lemfire_rate > 0:
		lemfire_rate -= 1

func shoot():
	var bullet = projectile.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func bb_shoot():
	var bullet = bb_projectile.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func rasp_shoot():
	var bullet = rasp_projectile.instance()
	add_child(bullet)
	level.move_child(bullet, 0)

func lem_shoot_small():
	var bullet = lem_projectile_small.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func lem_shoot_med():
	var bullet = lem_projectile_med.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func lem_shoot_big():
	var bullet = lem_projectile_big.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func _on_Area2D_area_entered(area):
	if area == get_parent().get_node("Pickups/Extra Health/Area2D") or area == get_parent().get_node("Enemies/Extra Health/Area2D"):
		if health < 4:
			health += 1
			print("You gained 1 health")
		else:
			print("You have full health!")
	elif area == get_parent().get_node("Pickups/Blueberry Upgrade/Area2D") or area == get_parent().get_node("Enemies/Blueberry Upgrade/Area2D"):
		blueberryupgrade()
	elif area == get_parent().get_node("Pickups/Raspberry Upgrade/Area2D") or area == get_parent().get_node("Enemies/Raspberry Upgrade/Area2D"):
		raspberryupgrade()
	elif area == get_parent().get_node("Pickups/Lemon Upgrade/Area2D") or area == get_parent().get_node("Enemies/Lemon Upgrade/Area2D"):
		lemonupgrade()
	elif area == get_parent().get_node("Pickups/Extra Life/Area2D") or area == get_parent().get_node("Enemies/Extra Life/Area2D"):
		if lives.lives < 5:
			lives.lives += 1
	else:
		health -= 1
		print("You've been hit!")
	if health == 4:
		health_green.visible = true
		health_yellow.visible = true
		health_orange.visible = true
		health_red.visible = true
	elif health == 3:
		health_green.visible = false
		health_yellow.visible = true
		health_orange.visible = true
		health_red.visible = true
	elif health == 2:
		health_green.visible = false
		health_yellow.visible = false
		health_orange.visible = true
		health_red.visible = true
	elif health == 1:
		health_green.visible = false
		health_yellow.visible = false
		health_orange.visible = false
		health_red.visible = true
	elif health == 0:
		health_green.visible = false
		health_yellow.visible = false
		health_orange.visible = false
		health_red.visible = false

func blueberryupgrade():
	idle = "bb_idle"
	left = "bb_left"
	right = "bb_right"
	idle_left = "bb_idle_left"
	idle_right = "bb_idle_right"

func raspberryupgrade():
	idle = "rasp_idle"
	left = "rasp_left"
	right = "rasp_right"
	idle_left = "rasp_idle_left"
	idle_right = "rasp_idle_right"

func lemonupgrade():
	idle = "lem_idle"
	left = "lem_left"
	right = "lem_right"
	idle_left = "lem_idle_left"
	idle_right = "lem_idle_right"
