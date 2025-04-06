# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source : String = 'res://scripts/components/settings.gd'

#region Variables
var test_dir : DirAccess
var runner : GdUnitSceneRunner
var settings_label : Label
var settings_component : Control

var consts : SettingsTestConsts = SettingsTestConsts.new()
var utilities : SettingsTestUtilities = SettingsTestUtilities.new()
#endregion


## before any test, create the Settings object and add the filepaths for the test
func before() -> void:
	test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)


## before every test:
## delete the test settings.json if one exists
## reload the scene runner and change the settings.json reference
func before_test() -> void:
	test_dir.remove("settings.json")
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	settings_label = runner.find_child("SettingsLabel")


## after all tests, close/free the DirAccess object
func after() -> void:
	test_dir = null


#region Tests
## test__open_settings() checks if the settings menu button opens the settings menu.
func test__open_settings() -> void:
	# Arrange
	# Act
	runner.set_mouse_position(settings_label.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	settings_component = runner.find_child("Settings")
	# Assert
	assert_bool(settings_component.visible)


## test__initialize_settings() checks if settings.json is created when there is no existing one, and
## that it matches the json string in the consts autoload.
func test__initialize_settings() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_INITIALIZE_EXP_PATH)
	var actual_dict : Dictionary
	# Act
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)


#func test__reset_to_default() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_INITIALIZE_EXP_PATH)
	#var dummy_dict : Dictionary = utilities.get_json_data(consts.TEST_INITIALIZE_EXP_PATH)
	#var actual_dict : Dictionary
	#var runner : GdUnitSceneRunner
	#utilities.replace_test_settings_data(consts.TEST_RESET_DUMMY_PATH)
	## Act
	#runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	#runner.invoke("on_main_menu_label_clicked", GlobalEnums.MainMenuButtonID.SETTINGS)
	## Assert
	#

#endregion
