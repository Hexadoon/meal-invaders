extends KinematicBody2D

var projectile
var counter = 0
var level

func _ready():
	projectile = load("res://enemies/Yoghurt Blob.tscn")
	level = get_parent()

func _physics_process(delta):
	$"AnimatedSprite".play()
	if counter == 150:
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
	queue_free()
	randomize()
	var rng = int(rand_range(1, 101))
	print(rng)
	if rng >= 1 and rng <= 10:
		dropitem()

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

