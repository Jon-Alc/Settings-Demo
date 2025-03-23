extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.MainMenuLabelClicked.connect(on_main_menu_label_clicked)


func on_main_menu_label_clicked(label_id):
	match label_id:
		GlobalEnums.MainMenuButtonID.SETTINGS:
			print(label_id)
