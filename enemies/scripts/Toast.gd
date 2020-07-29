extends KinematicBody2D

var projectile
var counter = 0
var level
var lives = 3
var drop = false
var camera_pos = Vector2()

func _ready():
	projectile = load("res://enemies/Butter.tscn")
	level = get_parent()

func _physics_process(delta):
	$"AnimatedSprite".play()
	camera_pos = get_parent().get_parent().get_node("Camera").position
	if counter == 100:
		if camera_pos.y < position.y + 350:
			shoot()
			counter = 0
	else:
		counter += 1

func shoot():
	var bullet = projectile.instance()
	bullet.position = get_global_position()
	level.add_child(bullet)
	level.move_child(bullet, 0)

func _on_Area2D_area_entered(area):
	if lives == 0:
		if drop == true:
			pass
		else:
			queue_free()
			randomize()
			var rng = int(rand_range(1, 101))
			if rng >= 1 and rng <= 5:
				dropitem()
			drop = true
	else:
		lives -= 1

func dropitem():
	randomize()
	var rng = int(rand_range(1, 5))
	var drop
	if rng == 1:
		drop = load("res://pickups/Extra Health.tscn")
	elif rng == 2:
		drop = load("res://pickups/Blueberry Upgrade.tscn")
	elif rng == 3:
		drop = load("res://pickups/Lemon Upgrade.tscn")
	elif rng == 4:
		drop = load("res://pickups/Raspberry Upgrade.tscn")
	var dropinstance = drop.instance()
	dropinstance.position = get_global_position()
	level.add_child(dropinstance)
	level.move_child(dropinstance, 0)

