extends Node

## SETTINGS_PATH is where the settings.json is stored.
## user://settings.json" is the path, which is "C:\Users\[User]\AppData\Roaming\Godot\app_userdata"
const SAVE_PATH : String = "user://"
const SETTINGS_FILE_PATH : String = "user://settings/settings.json"
const DEFAULT_SETTINGS_FILE_CONTENTS : String = \
	'{\n' + \
		'\t"resolution": "_1366x768",\n' + \
		'\t"window_mode": "WINDOWED",\n' + \
		'\t"framerate": 60,\n' + \
		'\t"vsync": "ON",\n' + \
		'\t"background": 1,\n' + \
		'\t"master_volume": 75,\n' + \
		'\t"music_volume": 75,\n' + \
		'\t"sound_volume": 75\n' + \
	'}\n'
