extends Control

func _process(delta):
	if visible:
		if $"Buttons/Resume".has_focus():
			$"Arrows/Resume Arrow".visible = true
			$"Arrows/Back To Menu Arrow".visible = false
		elif $"Buttons/Back To Menu".has_focus():
			$"Arrows/Resume Arrow".visible = false
			$"Arrows/Back To Menu Arrow".visible = true
	else:
		$"Arrows/Resume Arrow".visible = false
		$"Arrows/Back To Menu Arrow".visible = false

func _input(event):
	if Input.is_action_pressed("ui_cancel"):
		$"Buttons/Resume".grab_focus()
		get_tree().paused = not get_tree().paused
		visible = not visible

func _on_Resume_pressed():
	get_tree().paused = not get_tree().paused
	visible = not visible

func _on_Back_To_Menu_pressed():
	get_tree().paused = not get_tree().paused
	get_tree().change_scene("res://title_screen/Title Screen.tscn")
