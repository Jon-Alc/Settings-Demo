class_name Settings
extends Control

#region Variables
@onready var settings: Control = $"."
@onready var display_prompt: Control = %DisplayPrompt
@onready var resolution_options: OptionButton = %ResolutionOptions
@onready var window_mode_options: OptionButton = %FullscreenOptions
@onready var framerate_spin_box: SpinBox = %FramerateSpinBox
@onready var vsync_options: OptionButton = %VSyncOptions
@onready var background_check_box: CheckBox = %BackgroundCheckBox
@onready var master_volume_slider: HSlider = %MasterVolumeSlider
@onready var music_volume_slider: HSlider = %MusicVolumeSlider
@onready var sound_volume_slider: HSlider = %SoundVolumeSlider
@onready var sfx_audio_stream: AudioStreamPlayer2D = %SFXAudioStream

## the path of the parent folder to the settings file, saved here for caching and testing
## in-game, it should be defined to GlobalConsts.SAVE_PATH
var parent_folder_path: String
## the path to the settings file, saved here for caching and testing
## in-game, it should be defined to GlobalConsts.SETTINGS_FILE_PATH
var settings_file_path: String

## the resolution of the game, read from settings.json
var resolution_setting : GlobalEnums.DisplaySettingsID
## the resolution currently set while browsing the settings component
var current_resolution : GlobalEnums.DisplaySettingsID
## set when a new resolution option is selected; will overwrite current_resolution if the display
## prompt is accepted
var new_resolution : GlobalEnums.DisplaySettingsID

## the window mode of the game, read from settings.json
var window_mode_setting : GlobalEnums.WindowModeSettingsID
## the window mode currently set while browsing the settings component
var current_window_mode : GlobalEnums.WindowModeSettingsID

## the max framerate of the game, read from settings.json
var max_framerate_setting : int
## the max framerate currently set while browsing the settings component
var current_max_framerate : int

## the vsync setting of the game, read from settings.json
var vsync_setting : GlobalEnums.VSyncSettingsID
## the vsync setting currently set while browsing the settings component
var current_vsync : GlobalEnums.VSyncSettingsID

## the play-in-background setting of the game, read from settings.json
var play_in_bg_setting : bool
## the play-in-background setting currently set while browsing the settings component
var current_play_in_bg : bool

## the master volume level, read from settings.json
var master_volume_setting : int
## the master volume level currently set while browsing the settings component
var current_master_volume : int

## the music volume level, read from settings.json
var music_volume_setting : int
## the music volume level currently set while browsing the settings component
var current_music_volume : int

## the sound volume level, read from settings.json
var sound_volume_setting : int
## the sound volume level currently set while browsing the settings component
var current_sound_volume : int
#endregion


func _init(given_parent_folder_path: String=GlobalConsts.SAVE_PATH,
given_settings_file_path: String=GlobalConsts.SETTINGS_FILE_PATH) -> void:
	parent_folder_path = given_parent_folder_path
	settings_file_path = given_settings_file_path


#region _ready() functions
func _ready() -> void:
	_initialize()


## _initialize() initializes settings variables. It reads them from an existing settings.json file,
## or creates a new one if one isn't found.
func _initialize() -> void:
	
	if not FileAccess.file_exists(settings_file_path):
		print("No settings.json found, making new one...")
		_initialize_settings()

	_read_settings()
	_change_resolution(resolution_setting)
	_change_window_mode(window_mode_setting)
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
func _on_resolution_option_item_selected(index: int) -> void:
	new_resolution = GlobalEnums.int_to_display_settings_id(index)
	_change_resolution(new_resolution)
	display_prompt.timed_prompt(
		"Would you like to keep these settings?", 15, _display_prompt_accept_resolution,
		_display_prompt_cancel_resolution, _display_prompt_cancel_resolution
	)
#endregion

#region Callbacks
## Called when the user accepts the Display Prompt to keep the new resolution.
func _display_prompt_accept_resolution() -> void:
	current_resolution = new_resolution


## Called when the user cancels the Display Prompt to keep the new resolution. It undoes the
## selected resolution.
func _display_prompt_cancel_resolution() -> void:
	resolution_options.selected = current_resolution
	_change_resolution(current_resolution)
#endregion
#endregion


#region Window mode feature functions
func _change_window_mode(window_mode: GlobalEnums.WindowModeSettingsID) -> void:
	
	current_window_mode = window_mode
	
	match current_window_mode:
		GlobalEnums.WindowModeSettingsID.FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		GlobalEnums.WindowModeSettingsID.WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
		GlobalEnums.WindowModeSettingsID.BORDERLESS_WINDOWED:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)


#region Signals
func _on_fullscreen_options_item_selected(index: int) -> void:
	_change_window_mode(GlobalEnums.int_to_window_mode_settings_id(index))
#endregion
#endregion


#region Max framerate feature functions
func _get_current_framerate() -> int:
	return framerate_spin_box.value
#endregion


#region VSync feature functions
## _change_vsync_mode() changes the VSync setting depending on which setting was chosen.
func _change_vsync_mode(new_vsync: GlobalEnums.VSyncSettingsID) -> void:
	
	match new_vsync:
		GlobalEnums.VSyncSettingsID.OFF: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		GlobalEnums.VSyncSettingsID.ON: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
		GlobalEnums.VSyncSettingsID.ADAPTIVE: DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE)


#region Signals
func _on_vsync_options_item_selected(index: int) -> void:
	current_vsync = GlobalEnums.int_to_vsync_settings_id(index)
	_change_vsync_mode(current_vsync)
#endregion
#endregion


#region Play in Background feature functions
#region Signals
func _on_background_check_box_toggled(toggled_on: bool) -> void:
	current_play_in_bg = toggled_on
#endregion
#endregion


#region Volume sliders feature functions
#region Signals
func _on_master_volume_slider_value_changed(value: float) -> void:
	current_master_volume = int(value)
	AudioServer.set_bus_volume_linear(GlobalEnums.AudioBusIndex.MASTER, value / 100)


func _on_music_volume_slider_value_changed(value: float) -> void:
	current_music_volume = int(value)
	AudioServer.set_bus_volume_linear(GlobalEnums.AudioBusIndex.MUSIC, value / 100)


func _on_sound_volume_slider_value_changed(value: float) -> void:
	current_sound_volume = int(value)
	AudioServer.set_bus_volume_linear(GlobalEnums.AudioBusIndex.SFX, value / 100)
	sfx_audio_stream.play()
#endregion
#endregion


#region Settings component-specific functions
## _read_settings() is called if there is an existing settings.json file. It parses the settings
## file and sets the game's current settings. If the file can't be read, it deletes this file and
## creates a new one.
func _read_settings() -> void:
		
	var readfile : FileAccess = FileAccess.open(settings_file_path, FileAccess.READ)
	var settings_string : String = readfile.get_as_text()
	print(settings_string)
	
	var value : Variant = JSON.parse_string(settings_string)
	
	# if settings.json couldn't be read
	if not value:
		print("settings.json unable to be read, re-initializing settings...")
		readfile = null
		_initialize_settings()
		_read_settings()
		return
	
	var settings_dict : Dictionary = JSON.parse_string(settings_string)
	var resolution_value : String = settings_dict["resolution"]
	var window_mode_value : String = settings_dict["window_mode"]
	var max_framerate_value : int = settings_dict["framerate"]
	var vsync_value : String = settings_dict["vsync"]
	var play_in_bg_value : bool = bool(settings_dict["background"])
	var master_volume_value : int = settings_dict["master_volume"]
	var music_volume_value : int = settings_dict["music_volume"]
	var sound_volume_value : int = settings_dict["sound_volume"]
	
	resolution_setting = GlobalEnums.str_to_display_settings_id(resolution_value)
	current_resolution = resolution_setting
	resolution_options.selected = resolution_setting
	
	window_mode_setting = GlobalEnums.str_to_window_mode_settings_id(window_mode_value)
	current_window_mode = window_mode_setting
	window_mode_options.selected = window_mode_setting
	
	max_framerate_setting = max_framerate_value
	current_max_framerate = max_framerate_value
	framerate_spin_box.value = current_max_framerate
	
	vsync_setting = GlobalEnums.str_to_vsync_settings_id(vsync_value)
	current_vsync = vsync_setting
	vsync_options.selected = vsync_setting
	
	play_in_bg_setting = play_in_bg_value
	current_play_in_bg = play_in_bg_value
	background_check_box.button_pressed = play_in_bg_value
	
	master_volume_setting = master_volume_value
	current_master_volume = master_volume_value
	master_volume_slider.value = current_master_volume
	
	music_volume_setting = music_volume_value
	current_music_volume = music_volume_value
	music_volume_slider.value = current_music_volume
	
	sound_volume_setting = sound_volume_value
	current_sound_volume = sound_volume_value
	sound_volume_slider.value = current_sound_volume


## _initialize_settings() is called if there is no settings.json file, or it can't be read. It
## creates a new settings.json file in the AppData folder, and initializes default settings.
func _initialize_settings() -> void:
	
	# create settings folder and initialize settings.json file
	var dir : DirAccess = DirAccess.open(parent_folder_path)
	dir.make_dir("settings")
	
	# delete settings.json and re-initialize
	if dir.file_exists(settings_file_path):
		print("Settings file already exists, re-initializing...")
		if dir.remove(settings_file_path) != OK:
			# it's possible that the file was opened earlier in the code
			print("settings.json couldn't be deleted. Exiting...")
			get_tree().quit(1)
		
	var file : FileAccess = FileAccess.open(settings_file_path, FileAccess.WRITE)
	file.store_string(GlobalConsts.DEFAULT_SETTINGS_FILE_CONTENTS)
	
	
## _save_settings() takes the current settings session's variables and "overwrites" the settings
## file by deleting it and creating it. It also updates the cached settings variables for this
## session.
func _save_settings() -> void:
	
	resolution_setting = current_resolution
	window_mode_setting = current_window_mode
	max_framerate_setting = _get_current_framerate()
	vsync_setting = current_vsync
	play_in_bg_setting = current_play_in_bg
	master_volume_setting = current_master_volume
	music_volume_setting = current_music_volume
	sound_volume_setting = current_sound_volume
	
	# ensure folder exists--make_dir() doesn't do anything if the folder already exists
	var dir : DirAccess = DirAccess.open(parent_folder_path)
	dir.make_dir("settings")
	
	# delete settings.json and save settings
	if dir.file_exists(settings_file_path):
		if dir.remove(settings_file_path) != OK:
			# it's possible that the file was opened earlier in the code
			print("settings.json couldn't be deleted. Exiting...")
			get_tree().quit(1)
		
	var file_contents : String = \
		'{\n' + \
			'\t"resolution": "%s",\n' % GlobalEnums.DisplaySettingsID.keys()[resolution_setting] + \
			'\t"window_mode": "%s",\n' % GlobalEnums.WindowModeSettingsID.keys()[window_mode_setting] + \
			'\t"framerate": %d,\n' % max_framerate_setting + \
			'\t"vsync": "%s",\n' % GlobalEnums.VSyncSettingsID.keys()[vsync_setting] + \
			'\t"background": %d,\n' % int(play_in_bg_setting) + \
			'\t"master_volume": %d,\n' % master_volume_setting + \
			'\t"music_volume": %d,\n' % music_volume_setting + \
			'\t"sound_volume": %d\n' % sound_volume_setting + \
		'}'	
	print("to write:\n" + file_contents)
	var file : FileAccess = FileAccess.open(settings_file_path, FileAccess.WRITE)
	file.store_string(file_contents)


#region Signals
## Saves all changes from current session to the settings.json file
func _on_save_changes_button_pressed() -> void:
	sfx_audio_stream.play()
	GlobalEvents.SettingsSaveChangesPressed.emit()
	_save_settings()
	Engine.max_fps = framerate_spin_box.value
	settings.visible = false


## Deletes the settings.json file and re-initializes it
func _on_reset_default_button_pressed() -> void:
	sfx_audio_stream.play()
	display_prompt.prompt("Are you sure you want to reset your settings to the default?",
	_display_prompt_accept_reset)


## Reverts all settings to the settings.json file
func _on_cancel_button_pressed() -> void:
	
	sfx_audio_stream.play()
	
	# undo all changes
	if current_resolution != resolution_setting:
		current_resolution = resolution_setting
		resolution_options.selected = resolution_setting
		_change_resolution(resolution_setting)
	
	if current_window_mode != window_mode_setting:
		current_window_mode = window_mode_setting
		window_mode_options.selected = window_mode_setting
		_change_window_mode(window_mode_setting)
	
	if current_max_framerate != max_framerate_setting:
		current_max_framerate = max_framerate_setting
		framerate_spin_box.value = max_framerate_setting
		# don't have to change framerate, as it's only applied when saving settings
	
	if current_vsync != vsync_setting:
		current_vsync = vsync_setting
		vsync_options.selected = vsync_setting
		_change_vsync_mode(vsync_setting)
	
	if current_play_in_bg != play_in_bg_setting:
		current_play_in_bg = play_in_bg_setting
		# don't have to change anything; only if the game loses focus
	
	if current_master_volume != master_volume_setting:
		current_master_volume = master_volume_setting
		master_volume_slider.value = master_volume_setting
	
	if current_music_volume != music_volume_setting:
		current_music_volume = music_volume_setting
		music_volume_slider.value = music_volume_setting
	
	if current_sound_volume != sound_volume_setting:
		current_sound_volume = sound_volume_setting
		sound_volume_slider.value = sound_volume_setting
	
	settings.visible = false
#endregion


#region Callbacks
## Called when the user accepts the Display Prompt to reset to default. Deletes the existing
## settings.json, re-initializes it, and re-reads it.
func _display_prompt_accept_reset() -> void:
	_initialize_settings()
	_read_settings()
#endregion
#endregion
