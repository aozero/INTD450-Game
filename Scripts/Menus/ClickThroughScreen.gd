extends ColorRect

func _input(event):
	if event is InputEventMouseButton or event.is_action_pressed("ui_accept") or event.is_action_pressed("ui_cancel"):
		click_action()
