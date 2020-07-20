extends Control

var lives

func _ready():
	lives = get_node("/root/PlayerVariables")
	$"Buttons/Play Again".grab_focus()

func _process(delta):
	if $"Buttons/Play Again".has_focus():
		$"Arrows/Play Again Arrow".visible = true
		$"Arrows/Exit To Menu Arrow".visible = false
	else:
		$"Arrows/Play Again Arrow".visible = false
		$"Arrows/Exit To Menu Arrow".visible = true

func _on_Play_Again_pressed():
	lives.lives = 3
	get_tree().change_scene("res://level_1/Level 1.tscn")

func _on_Exit_To_Menu_pressed():
	get_tree().change_scene("res://title_screen/Title Screen.tscn")
