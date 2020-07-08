extends Control

func _ready():
	$"Buttons/Start".grab_focus()

func _process(delta):
	if $"Buttons/Start".has_focus():
		$"Arrows/Start Arrow".visible = true
		$"Arrows/Options Arrow".visible = false
		$"Arrows/Quit Arrow".visible = false
	elif $"Buttons/Options".has_focus():
		$"Arrows/Start Arrow".visible = false
		$"Arrows/Options Arrow".visible = true
		$"Arrows/Quit Arrow".visible = false
	elif $"Buttons/Quit".has_focus():
		$"Arrows/Start Arrow".visible = false
		$"Arrows/Options Arrow".visible = false
		$"Arrows/Quit Arrow".visible = true
	else:
		pass

func _on_Start_pressed():
	get_tree().change_scene("res://level_1/Level 1.tscn")

func _on_Options_pressed():
	pass

func _on_Quit_pressed():
	get_tree().quit()
