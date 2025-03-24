extends Control

@onready var settings: Control = $"."
@onready var display_prompt: Control = %DisplayPrompt


var prompt_timer : SceneTreeTimer
var player_responded_to_prompt : bool


func _ready() -> void:
	initialize()
	GlobalEvents.DisplayPromptButtonPressed.connect(on_display_prompt_button_pressed)
	GlobalEvents.DisplayPromptResponded.connect(on_display_prompt_responded)


func initialize() -> void:
	reset_prompt_variables()


func reset_prompt_variables() -> void:
	print("Reseting prompt variables")
	prompt_timer = null
	player_responded_to_prompt = false


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
	
	# center the window after changing resolution
	var center_position = DisplayServer.screen_get_position() + (DisplayServer.screen_get_size() / 2)
	var window_size = get_window().get_size_with_decorations()
	get_window().set_position(center_position - (window_size / 2))
	
	prompt_timer = get_tree().create_timer(15)
	display_prompt.visible = true
	await confirm_resolution_change()
	print("After it all")


func _on_save_changes_button_pressed() -> void:
	GlobalEvents.SettingsSaveChangesPressed.emit()
	settings.visible = false


func _on_cancel_button_pressed() -> void:
	settings.visible = false


func confirm_resolution_change() -> void:
	
	while prompt_timer.time_left > 0:
		display_prompt.prompt_text.text = "Would you like to keep these settings? (%s)" % str(int(prompt_timer.time_left))
		print(prompt_timer.time_left)
		await get_tree().create_timer(.1).timeout
	
	if not player_responded_to_prompt:
		GlobalEvents.DisplayPromptResponded.emit(false)
	
	reset_prompt_variables()


## on_display_prompt_button_pressed is an event function intended to interrupt
## confirm_resolution_change. This is until a cleaner way to StopCoroutine() has been found.
func on_display_prompt_button_pressed() -> void:
	
	if not prompt_timer:
		return
		
	player_responded_to_prompt = true
	prompt_timer.time_left = 0


func on_display_prompt_responded(response : bool) -> void:
	print("on_display_prompt_responded" + str(response))
