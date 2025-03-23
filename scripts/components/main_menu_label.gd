extends Label

const MAIN_MENU = preload("res://ui/themes/main_menu.tres")
const OPTION_SELECTED = preload("res://ui/themes/option_selected.tres")


func _ready() -> void:
	set_theme(MAIN_MENU)

func _on_mouse_entered() -> void:
	set_theme(OPTION_SELECTED)

func _on_mouse_exited() -> void:
	set_theme(MAIN_MENU)
