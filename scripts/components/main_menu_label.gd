extends Label

@export var MAIN_MENU_OPTION : Theme
@export var OPTION_SELECTED : Theme
@export var LABEL_ID : GlobalEnums.MainMenuButtonID

func _ready() -> void:
	set_theme(MAIN_MENU_OPTION)

func _on_mouse_entered() -> void:
	set_theme(OPTION_SELECTED)

func _on_mouse_exited() -> void:
	set_theme(MAIN_MENU_OPTION)
	
func _on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("LeftClick"):
		# print("%s pressed" % MainMenuButtonID.keys()[LABEL_ID])
		GlobalEvents.MainMenuLabelPressed.emit(LABEL_ID)
