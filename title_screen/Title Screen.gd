extends Control

func _ready():
	$"Buttons/Start".grab_focus()

func _on_Start_pressed():
	get_tree().change_scene("res://level_1/Level 1.tscn")

func _on_Options_pressed():
	pass

func _on_Quit_pressed():
	get_tree().quit()
