extends Control

@onready var display_prompt: Control = $"."
@onready var prompt_text: Label = %PromptText


func _on_accept_button_pressed() -> void:
	GlobalEvents.DisplayPromptButtonPressed.emit()
	GlobalEvents.DisplayPromptResponded.emit(true)
	display_prompt.visible = false


func _on_cancel_button_pressed() -> void:
	GlobalEvents.DisplayPromptButtonPressed.emit()
	GlobalEvents.DisplayPromptResponded.emit(false)
	display_prompt.visible = false
