extends Node

enum MainMenuButtonID {
	CONTINUE,
	NEW_GAME,
	SETTINGS,
	EXIT,
	NULL
}


enum DisplaySettingsID {
	_640x480 = 0,
	_800x600 = 1,
	_1366x768 = 2,
	_1600x900 = 3,
	_1920x1080 = 4,
	_1920x1200 = 5,
	_2560x1440 = 6,
	_2560x1600 = 7,
	_3840x2160 = 8,
	NULL = -1
}


func int_to_display_settings_id(value: int) -> DisplaySettingsID:
	
	var key : DisplaySettingsID = DisplaySettingsID.NULL
	
	match value:
		8: key = DisplaySettingsID._3840x2160
		7: key = DisplaySettingsID._2560x1600
		6: key = DisplaySettingsID._2560x1440
		5: key = DisplaySettingsID._1920x1200
		4: key = DisplaySettingsID._1920x1080
		3: key = DisplaySettingsID._1600x900
		2: key = DisplaySettingsID._1366x768
		1: key = DisplaySettingsID._800x600
		0: key = DisplaySettingsID._640x480
	
	return key


func str_to_display_settings_id(value: String) -> DisplaySettingsID:
	
	var key : DisplaySettingsID = DisplaySettingsID.NULL
	
	match value:
		"_3840x2160": key = DisplaySettingsID._3840x2160
		"_2560x1600": key = DisplaySettingsID._2560x1600
		"_2560x1440": key = DisplaySettingsID._2560x1440
		"_1920x1200": key = DisplaySettingsID._1920x1200
		"_1920x1080": key = DisplaySettingsID._1920x1080
		"_1600x900": key = DisplaySettingsID._1600x900
		"_1366x768": key = DisplaySettingsID._1366x768
		"_800x600": key = DisplaySettingsID._800x600
		"_640x480": key = DisplaySettingsID._640x480
	
	return key


enum WindowModeSettingsID {
	FULLSCREEN = 0,
	WINDOWED = 1,
	BORDERLESS_WINDOWED = 2,
	NULL = -1
}


func int_to_window_mode_settings_id(value: int) -> WindowModeSettingsID:
	
	var key : WindowModeSettingsID = WindowModeSettingsID.NULL
	
	match value:
		0: key = WindowModeSettingsID.FULLSCREEN
		1: key = WindowModeSettingsID.WINDOWED
		2: key = WindowModeSettingsID.BORDERLESS_WINDOWED
	
	return key


func str_to_window_mode_settings_id(value: String) -> WindowModeSettingsID:
	
	var key : WindowModeSettingsID = WindowModeSettingsID.NULL
	
	match value:
		"FULLSCREEN": key = WindowModeSettingsID.FULLSCREEN
		"WINDOWED": key = WindowModeSettingsID.WINDOWED
		"BORDERLESS_WINDOWED": key = WindowModeSettingsID.BORDERLESS_WINDOWED
	
	return key


enum VSyncSettingsID {
	OFF = 0,
	ON = 1,
	ADAPTIVE = 2,
	NULL = -1
}


func int_to_vsync_settings_id(value: int) -> VSyncSettingsID:
	
	var key : VSyncSettingsID = VSyncSettingsID.NULL
	
	match value:
		0: key = VSyncSettingsID.OFF
		1: key = VSyncSettingsID.ON
		2: key = VSyncSettingsID.ADAPTIVE
		
	return key


func str_to_vsync_settings_id(value: String) -> VSyncSettingsID:
	
	var key : VSyncSettingsID = VSyncSettingsID.NULL
	
	match value:
		"OFF": key = VSyncSettingsID.OFF
		"ON": key = VSyncSettingsID.ON
		"ADAPTIVE": key = VSyncSettingsID.ADAPTIVE
		
	return key


enum AudioBusIndex {
	MASTER = 0,
	MUSIC = 1,
	SFX = 2,
	NULL = -1
}

# could add shortcut consts
#const NULL = MainMenuButtonID.NULL
#const CONTINUE = MainMenuButtonID.CONTINUE
#const NEW_GAME = MainMenuButtonID.NEW_GAME
#const SETTINGS = MainMenuButtonID.SETTINGS
#const EXIT = MainMenuButtonID.EXIT
