extends Control

func _ready():
	$Button.grab_focus()
	$Success.play()

func _on_Button_pressed():
	get_tree().change_scene("res://title_screen/Title Screen.tscn")
