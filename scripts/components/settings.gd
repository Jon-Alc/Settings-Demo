extends Control

@onready var settings: Control = $"."


func _on_save_changes_button_pressed() -> void:
	GlobalEvents.SettingsSaveChangesClicked.emit()
	settings.visible = false


func _on_cancel_button_pressed() -> void:
	settings.visible = false
