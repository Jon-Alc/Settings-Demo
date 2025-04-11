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

## How much to offset mouse position by. This ensures the mouse is over the UI element.
const BUTTON_OFFSET : Vector2 = Vector2(5, 5)
#endregion
