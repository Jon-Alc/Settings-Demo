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
## - delete the test settings.json if one exists
## - reload the scene runner and change the settings.json reference
## - find relevant settings nodes
func before_test() -> void:
	test_dir.remove("settings.json")
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	settings_label = runner.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")


## after all tests:
## - delete the settings.json one last time
## - close/free the DirAccess object
func after() -> void:
	test_dir.remove("settings.json")
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


## test__reset_to_default() replaces the settings data with dummy data different from initialized
## data. It then tests if the "reset to default" button resets the data properly.
func test__reset_to_default() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RESET_EXP_PATH)
	var dummy_dict : Dictionary = utilities.get_json_data(consts.TEST_RESET_DUMMY_PATH)
	var actual_dict : Dictionary
	var reset_button : Button = runner.find_child("ResetDefaultButton")
	var display_prompt : Control
	var accept_button : Button
	# Act
	utilities.replace_test_settings_data(consts.TEST_RESET_DUMMY_PATH)
	runner.set_mouse_position(settings_label.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	runner.set_mouse_position(reset_button.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	# DisplayPrompt gets instantiated, now find it and the accept button
	display_prompt = runner.find_child("DisplayPrompt")
	assert_that(display_prompt).is_not_null()
	assert(display_prompt.visible)
	
	accept_button = display_prompt.find_child("AcceptButton")
	runner.set_mouse_position(accept_button.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_that(display_prompt).is_null()
	assert_dict(actual_dict).is_not_equal(dummy_dict)
	assert_dict(actual_dict).is_equal(expected_dict)


func test__reset_cancel() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RESET_CANCEL_EXP_PATH)
	var actual_dict : Dictionary
	var reset_button : Button = runner.find_child("ResetDefaultButton")
	var display_prompt : Control
	var cancel_button : Button
	# Act
	utilities.replace_test_settings_data(consts.TEST_RESET_CANCEL_DUMMY_PATH)
	runner.set_mouse_position(settings_label.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	runner.set_mouse_position(reset_button.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	# DisplayPrompt gets instantiated, now find it and the cancel button
	display_prompt = runner.find_child("DisplayPrompt")
	assert_that(display_prompt).is_not_null()
	assert(display_prompt.visible)

	cancel_button = display_prompt.find_child("CancelButton")
	runner.set_mouse_position(cancel_button.get_screen_position() + consts.BUTTON_OFFSET)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_that(display_prompt).is_null()
	assert_dict(actual_dict).is_equal(expected_dict)
#endregion
