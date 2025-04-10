# GdUnit generated TestSuite
class_name TestConsts

#region Variables
#region Filepaths
## The path to the settings scene.
const TEST_STARTUP_SCENE_PATH : String = "res://test/scenes/test_startup.tscn"
## The path to the data folder, which is the parent of the test settings folder. Passed in to the
## settings component.
const TEST_PARENT_FOLDER_PATH : String = "res://test/data"
## The path to the settings folder. Used to delete the settings.json after each test.
const TEST_SETTINGS_FOLDER_PATH : String = "res://test/data/settings" 
## The path to the settings.json file. Passed in to the settings component.
const TEST_SETTINGS_FILE_PATH : String = "res://test/data/settings/settings.json"
#endregion

#region Settings Test
## The path to the expected output json for test__initialize_settings().
const TEST_INITIALIZE_EXP_PATH : String = \
	"res://test/data/settings/test__initialize_settings/expected_output.json"

## The path to the dummy input for settings.json, for test__reset_to_default().
const TEST_RESET_DUMMY_PATH : String = \
	"res://test/data/settings/test__reset_settings/dummy_settings.json"
## The path to the expected output json for test__reset_to_default().
const TEST_RESET_EXP_PATH : String = \
	"res://test/data/settings/test__reset_settings/expected_output.json"

## The path to the dummy input for settings.json, for test__reset_cancel().
const TEST_RESET_CANCEL_DUMMY_PATH : String = \
	"res://test/data/settings/test__reset_cancel/dummy_settings.json"
## The path to the expected output json for test__reset_cancel().
const TEST_RESET_CANCEL_EXP_PATH : String = \
	"res://test/data/settings/test__reset_cancel/expected_output.json"

## The path to the dummy input for settings.json, for test__fix_corrupted_settings().
const TEST_FIX_CORRUPTED_DUMMY_PATH : String = \
	"res://test/data/settings/test__fix_corrupted/dummy_settings.json"
## The path to the expected output json for test__fix_corrupted_settings().
const TEST_FIX_CORRUPTED_EXP_PATH : String = \
	"res://test/data/settings/test__fix_corrupted/expected_output.json"
#endregion

#region Resolution Test
## The path to the expected output json for test__resolution_640x480().
const TEST_RES_640X480_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_640x480/expected_output.json"

## The path to the expected output json for test__resolution_800x600().
const TEST_RES_800X600_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_800x600/expected_output.json"

## The path to the expected output json for test__resolution_1366X768().
const TEST_RES_1366X768_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_1366x768/expected_output.json"

## The path to the expected output json for test__resolution_1600X900().
const TEST_RES_1600X900_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_1600x900/expected_output.json"

## The path to the expected output json for test__resolution_1920X1080().
const TEST_RES_1920X1080_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_1920x1080/expected_output.json"

## The path to the expected output json for test__resolution_1920X1200().
const TEST_RES_1920X1200_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_1920x1200/expected_output.json"

## The path to the expected output json for test__resolution_2560X1440().
const TEST_RES_2560X1440_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_2560x1440/expected_output.json"

## The path to the expected output json for test__resolution_2560X1600().
const TEST_RES_2560X1600_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_2560x1600/expected_output.json"

## The path to the expected output json for test__resolution_3840X2160().
const TEST_RES_3840X2160_EXP_PATH : String = \
	"res://test/data/settings/test__resolution_3840x2160/expected_output.json"
#endregion

## How much to offset mouse position by. This ensures the mouse is over the UI element.
const BUTTON_OFFSET : Vector2 = Vector2(5, 5)
#endregion
