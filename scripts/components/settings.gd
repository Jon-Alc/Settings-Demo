extends Control

@onready var settings: Control = $"."
@onready var display_prompt: Control = %DisplayPrompt


var prompt_timer : SceneTreeTimer
var player_responded_to_prompt : bool

#region _ready() functions
func _ready() -> void:
	_initialize()
	GlobalEvents.DisplayPromptButtonPressed.connect(_on_display_prompt_button_pressed)
	GlobalEvents.DisplayPromptResponded.connect(_on_display_prompt_responded)
	
	var readfile = FileAccess.open("user://settings.json", FileAccess.READ)
	
	if readfile:
		_read_settings()
	else:
		_initialize_settings()



func _initialize() -> void:
	_reset_prompt_variables()


func _reset_prompt_variables() -> void:
	print("Resetting prompt variables")
	prompt_timer = null
	player_responded_to_prompt = false


func _read_settings() -> void:
	print("settings.json found")
	
	# if error parsing settings, re-initialize settings


func _initialize_settings() -> void:
	print("No settings.json found, making new one...")
	var file = FileAccess.open("user://settings.json", FileAccess.WRITE)
	print("Created settings.json")
	file.store_string(  '{\n' +
							'\t"resolution": "1366x768"\n' +
						'}\n')
	
	
	DisplayServer.window_set_size(Vector2i(1366, 768))
#endregion

#region Settings functions
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
	await _confirm_resolution_change()
	print("After it all")

#region Signals
func _on_save_changes_button_pressed() -> void:
	GlobalEvents.SettingsSaveChangesPressed.emit()
	settings.visible = false


func _on_cancel_button_pressed() -> void:
	settings.visible = false


#region GlobalEvents
## on_display_prompt_button_pressed is an event function intended to interrupt
## confirm_resolution_change. This is until a cleaner way to StopCoroutine() has been found.
func _on_display_prompt_button_pressed() -> void:
	
	if not prompt_timer:
		return
		
	player_responded_to_prompt = true
	prompt_timer.time_left = 0


func _on_display_prompt_responded(response : bool) -> void:
	print("on_display_prompt_responded" + str(response))
#endregion
#endregion

func _confirm_resolution_change() -> void:
	
	while prompt_timer.time_left > 0:
		display_prompt.prompt_text.text = "Would you like to keep these settings? (%s)" % str(int(prompt_timer.time_left))
		print(prompt_timer.time_left)
		await get_tree().create_timer(.1).timeout
	
	if not player_responded_to_prompt:
		GlobalEvents.DisplayPromptResponded.emit(false)
	
	_reset_prompt_variables()
#endregion
