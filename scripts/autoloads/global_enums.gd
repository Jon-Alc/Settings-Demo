extends Node

enum MainMenuButtonID {
	NULL,
	CONTINUE,
	NEW_GAME,
	SETTINGS,
	EXIT
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
	
# could add shortcut consts
#const NULL = MainMenuButtonID.NULL
#const CONTINUE = MainMenuButtonID.CONTINUE
#const NEW_GAME = MainMenuButtonID.NEW_GAME
#const SETTINGS = MainMenuButtonID.SETTINGS
#const EXIT = MainMenuButtonID.EXIT
