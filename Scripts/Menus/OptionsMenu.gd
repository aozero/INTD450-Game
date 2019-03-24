extends ColorRect

onready var quality_button = $VBoxContainer/Split/Right/ForestQuality/QualityButton
onready var shadow_box = $VBoxContainer/Split/Right/Shadows/ShadowBox
onready var back_button = $VBoxContainer/BackContainer/BackButton
onready var globals = get_node("/root/Globals")

func _ready():
	for i in globals.FOREST_QUALITY_TEXT:
		quality_button.add_item(i)
	
	quality_button.select(globals.get_forest_quality())
	shadow_box.pressed = globals.shadows

func _on_BackButton_button_up():
	visible = false

func _on_QualityButton_item_selected(ID):
	globals.set_forest_quality(ID)

func _on_CheckBox_button_up():
	# Is pressed returns true if the check mark is not there
	globals.set_shadows(!shadow_box.is_pressed())
	print(globals.get_shadows())
