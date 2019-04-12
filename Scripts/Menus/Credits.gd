extends ColorRect

onready var main_anim = $MainAnimator
onready var title_anim = $VBoxContainer/Title/TitleAnimator
onready var globals = get_node("/root/Globals")

func _ready():
	main_anim.play("start")
	title_anim.play("loop")

func quit_game():
	globals.return_to_main_menu()

func _input(event):
	if event.is_action_pressed("pause"):
		quit_game()

func _on_MainAnimator_animation_finished(anim_name):
	quit_game()
