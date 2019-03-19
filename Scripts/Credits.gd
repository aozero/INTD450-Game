extends ColorRect

func _input(event):
	if event is InputEventMouseButton or event is InputEventKey:
		get_tree().quit()
