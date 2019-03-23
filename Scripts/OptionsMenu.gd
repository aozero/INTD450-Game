extends ColorRect

onready var quality_button = $VBoxContainer/QualityContainer/HSplitContainer/QualityButton
onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var globals = get_node("/root/Globals")

func _ready():
	for i in globals.GRAPHICAL_QUALITY_TEXT:
		quality_button.add_item(i)

func _on_BackButton_button_up():
	visible = false

func _on_QualityButton_item_selected(ID):
	globals.set_quality_level(ID)
