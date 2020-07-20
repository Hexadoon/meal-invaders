extends Node2D

func _process(delta):
	if Input.is_action_just_pressed("ui_x"):
		get_tree().change_scene("res://level_1/Level 1.tscn")
