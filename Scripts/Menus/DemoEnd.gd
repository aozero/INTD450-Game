extends ColorRect

onready var globals = get_node("/root/Globals")
var grace_period_over = false

func _on_Timer_timeout():
	grace_period_over = true

func _input(event):
	if grace_period_over && event.is_pressed():
		globals.return_to_main_menu()