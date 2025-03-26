extends Node

## SETTINGS_PATH is where the settings.json is stored.
## user://settings.json" is the path, which is "C:\Users\[User]\AppData\Roaming\Godot\app_userdata"
const SAVE_PATH : String = "user://"
const SETTINGS_FILE_PATH : String = "user://settings/settings.json"
const DEFAULT_SETTINGS_FILE_CONTENTS : String = \
	'{\n' + \
		'\t"resolution": "1366x768"\n' + \
	'}\n'
