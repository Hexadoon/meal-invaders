extends Area2D

var camera
var boss

func _ready():
	camera = get_parent().get_node("Camera")
	boss = load("res://boss/Boss.tscn").instance()

func _on_Barrier_area_entered(area):
	camera.add_child(boss)
