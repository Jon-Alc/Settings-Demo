# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source : String = 'res://scripts/components/settings.gd'

#region Variables
# Filepaths
const test_parent_folder_path : String = "res://test/data"
const test_settings_file_path : String = "res://test/data/settings/settings.json"
const test_initialize_exp_path : String = "res://test/data/settings/test__initialize_settings/expected_output.json"

# before()
var settings : Settings
#endregion


## before every test, create the Settings object and add the filepaths for the test
func before() -> void:
	settings = auto_free(Settings.new(test_parent_folder_path, test_settings_file_path))


func test__initialize_settings() -> void:
	# Act
	var expected_dict : Dictionary = _get_json_data(test_initialize_exp_path)
	var actual_dict : Dictionary
	# Arrange
	settings._initialize_settings()
	actual_dict = _get_json_data(test_settings_file_path)
	print(actual_dict)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)


#region Helpers
func _get_json_data(file_path: String) -> Dictionary:
	var readfile : FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var file_contents : String = readfile.get_as_text()
	var data : Dictionary = JSON.parse_string(file_contents)
	return data
#endregion
