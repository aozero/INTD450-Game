extends Timer

onready var player = get_tree().get_root().get_node("World/Player")

func _on_Timer_timeout():
	player._on_Timer_timeout()
