extends Node2D

func _ready():
	$"Background Music".play()

func _on_Background_Music_finished():
	$"Background Music".play()
