extends Spatial

onready var ft1 = $FireTrigger
onready var ft2 = $FireTrigger2
onready var ft3 = $FireTrigger3
onready var ft4 = $FireTrigger4

func _on_FireTrigger_body_entered(body):
	if body.get_class() == "Player":
		for n in ft1.get_children():
			n.visible = true

func _on_FireTrigger2_body_entered(body):
	if body.get_class() == "Player":
		for n in ft2.get_children():
			n.visible = true
		ft2.visible = true


func _on_FireTrigger3_body_entered(body):
	if body.get_class() == "Player":
		for n in ft3.get_children():
			n.visible = true
		ft1.visible = false


func _on_FireTrigger4_body_entered(body):
	if body.get_class() == "Player":
		for n in ft4.get_children():
			n.visible = true
		ft2.visible = false
