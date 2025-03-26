extends Control

@onready var settings: Control = $"."
@onready var display_prompt: Control = %DisplayPrompt
@onready var resolution_options: OptionButton = %ResolutionOptions


var prompt_timer : SceneTreeTimer
var player_responded_to_prompt : bool

## the resolution of the game, read from settings.json
var resolution_setting : GlobalEnums.DisplaySettingsID
## the resolution currently set while browsing the settings component
var current_resolution : GlobalEnums.DisplaySettingsID
## set when a new resolution option is selected
var new_resolution : GlobalEnums.DisplaySettingsID

#region _ready() functions
func _ready() -> void:
	_initialize()
	GlobalEvents.DisplayPromptButtonPressed.connect(_on_display_prompt_button_pressed)
	GlobalEvents.DisplayPromptResponded.connect(_on_display_prompt_responded)


## _initialize() initializes settings variables. It reads them from an existing settings.json file,
## or creates a new one if one isn't found.
func _initialize() -> void:
	_reset_prompt_variables()
	
	if not FileAccess.file_exists(GlobalConsts.SETTINGS_FILE_PATH):
		print("No settings.json found, making new one...")
		_initialize_settings()

	_read_settings()


## _reset_prompt_variables() is called when the display prompt finishes an action, whether it's the
## user button press or timeout.
func _reset_prompt_variables() -> void:
	print("Resetting prompt variables")
	prompt_timer = null
	player_responded_to_prompt = false


## _read_settings() is called if there is an existing settings.json file. It parses the settings
## file and sets the game's current settings. If the file can't be read, it deletes this file and
## creates a new one.
func _read_settings() -> void:
	var readfile : FileAccess = FileAccess.open(GlobalConsts.SETTINGS_FILE_PATH, FileAccess.READ)
	var settings_string : String = readfile.get_as_text()
	print(settings_string)
	
	var value = JSON.parse_string(settings_string)
	
	# if settings.json couldn't be read
	if not value:
		print("settings.json unable to be read, re-initializing settings...")
		readfile = null
		_initialize_settings()
		_read_settings()
	
	var settings_dict : Dictionary = JSON.parse_string(settings_string)
	var res_value : String = settings_dict["resolution"]
	
	resolution_setting = GlobalEnums.str_to_display_settings_id(res_value)
	current_resolution = resolution_setting
	resolution_options.selected = resolution_setting
	
	_change_resolution(resolution_setting)


## _initialize_settings() is called if there is no settings.json file, or it can't be read. It
## creates a new settings.json file in the AppData folder, and initializes default settings.
func _initialize_settings() -> void:
	
	# create settings folder and initialize settings.json file
	var dir : DirAccess = DirAccess.open(GlobalConsts.SAVE_PATH)
	dir.make_dir("settings")
	
	# delete settings.json and re-initialize
	if dir.file_exists(GlobalConsts.SETTINGS_FILE_PATH):
		print("Settings file already exists, re-initializing...")
		if dir.remove(GlobalConsts.SETTINGS_FILE_PATH) != OK:
			# it's possible that the file was opened earlier in the code
			print("settings.json couldn't be deleted. Exiting...")
			get_tree().quit(1)
		
	var file : FileAccess = FileAccess.open(GlobalConsts.SETTINGS_FILE_PATH, FileAccess.WRITE)
	file.store_string(GlobalConsts.DEFAULT_SETTINGS_FILE_CONTENTS)
#endregion
#region Resolution feature functions
## _change_resolution() sets the window size to a given DisplaySettingsID and centers it.
func _change_resolution(new_res: GlobalEnums.DisplaySettingsID) -> void:
	
	match new_res:
		GlobalEnums.DisplaySettingsID._3840x2160: DisplayServer.window_set_size(Vector2i(3840, 2160))
		GlobalEnums.DisplaySettingsID._2560x1600: DisplayServer.window_set_size(Vector2i(2560, 1600))
		GlobalEnums.DisplaySettingsID._2560x1440: DisplayServer.window_set_size(Vector2i(2560, 1440))
		GlobalEnums.DisplaySettingsID._1920x1200: DisplayServer.window_set_size(Vector2i(1920, 1200))
		GlobalEnums.DisplaySettingsID._1920x1080: DisplayServer.window_set_size(Vector2i(1920, 1080))
		GlobalEnums.DisplaySettingsID._1600x900:  DisplayServer.window_set_size(Vector2i(1600, 900))
		GlobalEnums.DisplaySettingsID._1366x768:  DisplayServer.window_set_size(Vector2i(1366, 768))
		GlobalEnums.DisplaySettingsID._800x600:   DisplayServer.window_set_size(Vector2i(800, 600))
		GlobalEnums.DisplaySettingsID._640x480:   DisplayServer.window_set_size(Vector2i(640, 480))
		
	_center_window()


## _center_window() centers the game window by finding the middle position of the monitor,
## subtracting half the window size, and setting the window's position to the difference.
func _center_window() -> void:
	var center_position : Vector2i = DisplayServer.screen_get_position() + (DisplayServer.screen_get_size() / 2)
	var window_size : Vector2i = get_window().get_size_with_decorations()
	get_window().set_position(center_position - (window_size / 2))
	
	
#region Signals
## Changes the resolution and opens a display prompt
func _on_option_button_item_selected(index: int) -> void:
	new_resolution = GlobalEnums.int_to_display_settings_id(index)
	_change_resolution(new_resolution)
	await _confirm_resolution_change()


## Reverts all settings to the settings.json file
func _on_cancel_button_pressed() -> void:
	
	# undo all changes
	if current_resolution != resolution_setting:
		current_resolution = resolution_setting
		resolution_options.selected = resolution_setting
		_change_resolution(resolution_setting)
		
	settings.visible = false


#region GlobalEvents
## _on_display_prompt_button_pressed() is an event function intended to interrupt
## _confirm_resolution_change. This is until a cleaner way to StopCoroutine() has been found.
func _on_display_prompt_button_pressed() -> void:
	
	if not prompt_timer:
		return
		
	player_responded_to_prompt = true
	prompt_timer.time_left = 0


## _on_display_prompt_responded() is an event function that tracks whether the user responded to the
## display prompt or not. Currently, the only setting that opens a display prompt is resolution.
func _on_display_prompt_responded(response : bool) -> void:
	
	if not settings.visible: # if the settings menu isn't visible
		return

	if response: # if user accepts the resolution setting
		current_resolution = new_resolution
	else: # if user declines to keep the setting, or lets time run out
		resolution_options.selected = current_resolution
		_change_resolution(current_resolution)
		display_prompt.visible = false
#endregion
#endregion


## _confirm_resolution_change() is called when a user selects a new resolution option in the
## settings. It reveals a display prompt, asking the user to confirm to keep the changes, or not. If
## the user doesn't respond after 15 seconds, it will revert to the previous resolution.
func _confirm_resolution_change() -> void:
	
	prompt_timer = get_tree().create_timer(15)
	display_prompt.visible = true
	
	while prompt_timer.time_left > 0:
		display_prompt.prompt_text.text = "Would you like to keep these settings? (%s)" % str(ceili(prompt_timer.time_left))
		await get_tree().create_timer(.1).timeout
	
	if not player_responded_to_prompt:
		GlobalEvents.DisplayPromptResponded.emit(false)
	
	_reset_prompt_variables()
#endregion

#region Window type feature functions

#endregion

#region Settings component-specific functions
## _save_settings() takes the current settings session's variables and "overwrites" the settings
## file by deleting it and creating it. It also updates the cached settings variables for this
## session.
func _save_settings():
	
	resolution_setting = current_resolution
	
	# ensure folder exists--make_dir() doesn't do anything if the folder already exists
	var dir : DirAccess = DirAccess.open(GlobalConsts.SAVE_PATH)
	dir.make_dir("settings")
	
	# delete settings.json and save settings
	if dir.file_exists(GlobalConsts.SETTINGS_FILE_PATH):
		if dir.remove(GlobalConsts.SETTINGS_FILE_PATH) != OK:
			# it's possible that the file was opened earlier in the code
			print("settings.json couldn't be deleted. Exiting...")
			get_tree().quit(1)
		
	var file_contents = \
		'{\n' + \
			'\t"resolution":"%s"\n' % GlobalEnums.DisplaySettingsID.keys()[resolution_setting] + \
		'}'	
	print("to write:\n" + file_contents)
	var file : FileAccess = FileAccess.open(GlobalConsts.SETTINGS_FILE_PATH, FileAccess.WRITE)
	file.store_string(file_contents)
#region Signals
func _on_save_changes_button_pressed() -> void:
	GlobalEvents.SettingsSaveChangesPressed.emit()
	_save_settings()
	settings.visible = false
#endregion
#endregion
