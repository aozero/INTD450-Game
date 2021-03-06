extends StaticBody



onready var woosh_sound = $WooshSound
onready var firewall_sound1 = $FireWallSound
onready var firewall_sound2 = $FireWallSound2

func _ready():
	set_sound()

func _on_FireStrip_visibility_changed():
	if visible:
		woosh_sound.play()
	set_sound()

func set_sound():
	if visible:
		firewall_sound1.play()
		firewall_sound2.play()
	else:
		firewall_sound1.stop()
		firewall_sound2.stop()
	