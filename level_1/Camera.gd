extends Camera2D

var lives
var ani = "bg"

func _ready():
	lives = get_node("/root/PlayerVariables")

func _physics_process(delta):
	$AnimatedSprite.play(ani)
	position.y -= 1.65
	if lives.lives == 5:
		$"Lives/Lives Counter".set_text("x 5")
	elif lives.lives == 4:
		$"Lives/Lives Counter".set_text("x 4")
	elif lives.lives == 3:
		$"Lives/Lives Counter".set_text("x 3")
	elif lives.lives == 2:
		$"Lives/Lives Counter".set_text("x 2")
	elif lives.lives == 1:
		$"Lives/Lives Counter".set_text("x 1")

func _on_Barrier_area_entered(area):
	ani = "boss_bg"
