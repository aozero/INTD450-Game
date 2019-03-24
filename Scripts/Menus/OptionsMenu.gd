extends ColorRect

onready var quality_button = $VBoxContainer/QualityContainer/HSplitContainer/QualityButton
onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var globals = get_node("/root/Globals")

func _ready():
	for i in globals.FOREST_QUALITY_TEXT:
		quality_button.add_item(i)
	
	quality_button.select(globals.curr_forest_quality)

func _on_BackButton_button_up():
	visible = false

func _on_QualityButton_item_selected(ID):
	globals.set_forest_quality(ID)
