extends Area2D

var camera
var boss
var sound_played = false

func _ready():
	camera = get_parent().get_node("Camera")
	boss = load("res://boss/Boss.tscn").instance()

func _on_Barrier_area_entered(area):
	camera.add_child(boss)
	if !sound_played:
		$"Boss Intro".play()
		sound_played = true
