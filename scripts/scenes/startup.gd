extends Node

@onready var main_menu: Control = %MainMenu
@onready var settings: Control = %Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.MainMenuLabelClicked.connect(on_main_menu_label_clicked)


func on_main_menu_label_clicked(label_id):
	match label_id:
		GlobalEnums.MainMenuButtonID.SETTINGS:
			settings.visible = true
