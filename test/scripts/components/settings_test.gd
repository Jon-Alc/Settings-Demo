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
var main_menu : Control
var settings_label : Label
var settings_component : Control

var consts : TestConsts = TestConsts.new()
var settings_consts : TestSettingsConsts = TestSettingsConsts.new()
var utilities : TestUtilities = TestUtilities.new()
#endregion


## before any test, set up DirAccess
@warning_ignore('unused_parameter')
func before(
	do_skip : bool=DisplayServer.get_name().contains("headless"),
	skip_reason : String="Cannot run scene runner tests in headless mode."
) -> void:
	print("(SETTINGS_TEST) GET NAME: %s" % % DisplayServer.get_name())
	print("DOES IT CONTAIN HEADLESS? : %s" % DisplayServer.get_name().contains("headless"))
	test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)


## before every test, delete the test settings.json if one exists
func before_test() -> void:
	test_dir.remove("settings.json")


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
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	_find_settings_nodes()
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	# Assert
	assert_bool(settings_component.visible).is_true()


## test__initialize_settings() checks if settings.json is created when there is no existing one, and
## that it matches the json string in the consts autoload.
func test__initialize_settings() -> void:
	
	# Arrange
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	var expected_dict : Dictionary = utilities.get_json_data(settings_consts.TEST_INITIALIZE_EXP_PATH)
	var actual_dict : Dictionary = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	
	# Act
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)


## test__reset_to_default() replaces the settings data with dummy data different from initialized
## data. It then tests if the "reset to default" button resets the data properly.
func test__reset_to_default() -> void:
	
	# Arrange
	utilities.replace_test_settings_data(settings_consts.TEST_RESET_DUMMY_PATH)
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	_find_settings_nodes()
	
	var expected_dict : Dictionary = utilities.get_json_data(settings_consts.TEST_RESET_EXP_PATH)
	var dummy_dict : Dictionary = utilities.get_json_data(settings_consts.TEST_RESET_DUMMY_PATH)
	var actual_dict : Dictionary
	var display_prompt : Control
	var accept_button : Button
	var reset_button : Button = runner.find_child("ResetDefaultButton")
	
	# Act
	# go to settings and click reset button
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	await utilities.move_to_element_and_click(runner, settings_component, reset_button)
	
	# DisplayPrompt gets instantiated, find it and assert it exists
	display_prompt = runner.find_child("DisplayPrompt")
	assert_that(display_prompt).is_not_null()
	assert_bool(display_prompt.visible).is_true()
	
	# find DisplayPrompt's accept button and click it
	accept_button = display_prompt.find_child("AcceptButton")
	await utilities.move_to_element_and_click(runner, settings_component, accept_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	
	# Assert
	assert_that(display_prompt).is_null()
	assert_dict(actual_dict).is_not_equal(dummy_dict)
	assert_dict(actual_dict).is_equal(expected_dict)


func test__reset_cancel() -> void:
	
	# Arrange
	utilities.replace_test_settings_data(settings_consts.TEST_RESET_CANCEL_DUMMY_PATH)
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	_find_settings_nodes()
	
	var expected_dict : Dictionary = utilities.get_json_data(settings_consts.TEST_RESET_CANCEL_EXP_PATH)
	var actual_dict : Dictionary
	var display_prompt : Control
	var cancel_button : Button
	var reset_button : Button = runner.find_child("ResetDefaultButton")
	
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	await utilities.move_to_element_and_click(runner, settings_component, reset_button)
	
	# DisplayPrompt gets instantiated, find it and assert it exists
	display_prompt = runner.find_child("DisplayPrompt")
	assert_that(display_prompt).is_not_null()
	assert_bool(display_prompt.visible).is_true()

	# find DisplayPrompt's cancel button and click it
	cancel_button = display_prompt.find_child("CancelButton")
	await utilities.move_to_element_and_click(runner, settings_component, cancel_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	
	# Assert
	assert_that(display_prompt).is_null()
	assert_dict(actual_dict).is_equal(expected_dict)


func test__fix_corrupted_settings() -> void:
	
	# Arrange
	utilities.replace_test_settings_data(settings_consts.TEST_FIX_CORRUPTED_DUMMY_PATH)
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	
	var expected_dict : Dictionary = utilities.get_json_data(settings_consts.TEST_FIX_CORRUPTED_EXP_PATH)
	var actual_dict : Dictionary = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	
	# Act
	
	# Assert
	assert_that(actual_dict).is_equal(expected_dict)
#endregion


#region Test Helpers
## _find_settings_nodes() finds the nodes that help navigate to the settings menu. It should be
## called after the runner starts up.
func _find_settings_nodes() -> void:
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")
#endregion
