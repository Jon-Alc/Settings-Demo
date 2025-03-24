extends Control

@onready var settings: Control = $"."


func _on_option_button_item_selected(index: int) -> void:
	match index:
		0: DisplayServer.window_set_size(Vector2i(3840, 2160))
		1: DisplayServer.window_set_size(Vector2i(2560, 1600))
		2: DisplayServer.window_set_size(Vector2i(2560, 1440))
		3: DisplayServer.window_set_size(Vector2i(1920, 1200))
		4: DisplayServer.window_set_size(Vector2i(1920, 1080))
		5: DisplayServer.window_set_size(Vector2i(1600, 900))
		6: DisplayServer.window_set_size(Vector2i(1366, 768))
		7: DisplayServer.window_set_size(Vector2i(800, 600))
		8: DisplayServer.window_set_size(Vector2i(640, 480))

	
func _on_save_changes_button_pressed() -> void:
	GlobalEvents.SettingsSaveChangesClicked.emit()
	settings.visible = false


func _on_cancel_button_pressed() -> void:
	settings.visible = false
