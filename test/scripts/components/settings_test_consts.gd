# GdUnit generated TestSuite
class_name SettingsTestConsts

#region Variables
# Filepaths
## The path to the settings scene.
const test_settings_scene_path : String = "res://test/scenes/test_startup.tscn"
## The path to the data folder, which is the parent of the test settings folder. Passed in to the
## settings component.
const test_parent_folder_path : String = "res://test/data"
## The path to the settings folder. Used to delete the settings.json after each test.
const test_settings_folder_path : String = "res://test/data/settings" 
## The path to the settings.json file. Passed in to the settings component.
const test_settings_file_path : String = "res://test/data/settings/settings.json"
## The path to the expected output json for test__initialize_settings().
const test_initialize_exp_path : String = \
	"res://test/data/settings/test__initialize_settings/expected_output.json"
## The path to the dummy input for settings.json, for test__reset_to_default().
const test_reset_dummy_path : String = \
	"res://test/data/settings/test__reset_settings/dummy_settings.json"
## The path to the expected output json for test__reset_to_default().
const test_reset_exp_path : String = \
	"res://test/data/settings/test__reset_settings/expected_output.json"
## The path to the expected output json for test__resolution_640x480().
const test_res_640x480_exp_path : String = \
	"res://test/data/settings/test__resolution_640x480/expected_output.json"
## How much to offset mouse position by. This ensures the mouse is over the UI element.
const button_offset : Vector2 = Vector2(5, 5)
#endregion
