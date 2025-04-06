# GdUnit generated TestSuite
class_name SettingsTestUtilities
var consts : SettingsTestConsts = SettingsTestConsts.new()

#region Helpers
## get_json_data() retrieves the json data from a given file's path.
func get_json_data(json_file_path: String) -> Dictionary:
	var readfile : FileAccess = FileAccess.open(json_file_path, FileAccess.READ)
	var file_contents : String = readfile.get_as_text()
	var data : Dictionary = JSON.parse_string(file_contents)
	return data

## replace_test_settings_data() replaces the test settings.json's data with another json file's
## data.
func replace_test_settings_data(json_file_path: String) -> void:
	var dir : DirAccess = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)
	dir.copy(json_file_path, "res://test/data/settings/settings.json")
#endregion
