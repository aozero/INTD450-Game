extends Control

func _on_YesButton_button_up():
	get_tree().quit()

func _on_NoButton_button_up():
	visible = false
