extends ColorRect

onready var main_anim = $MainAnimator

func _ready():
	main_anim.play("start")

func quit_game():
	get_tree().quit()

func _input(event):
	if event.is_action_pressed("pause"):
		quit_game()

func _on_MainAnimator_animation_finished(anim_name):
	quit_game()
