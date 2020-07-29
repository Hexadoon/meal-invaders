extends KinematicBody2D

var level
var lives = 5
var drop = false

func _ready():
	level = get_parent()

func _process(delta):
	$"AnimatedSprite".play()

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
