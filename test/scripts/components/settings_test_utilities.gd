# GdUnit generated TestSuite
class_name SettingsTestUtilities

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
	var dir : DirAccess = DirAccess.open("res://test/data/settings")
	dir.copy("test__reset_settings/dummy_settings.json", "settings.json")
#endregion
