# GdUnit generated TestSuite
class_name SettingsTestResolution
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
var utilities : TestUtilities = TestUtilities.new()
#endregion


## before any test, set up DirAccess
func before() -> void:
	test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)


## before every test:
## - delete the test settings.json if one exists
## - reload the scene runner and change the settings.json reference
## - find relevant settings nodes
func before_test() -> void:
	test_dir.remove("settings.json")
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")
	
	
## after all tests:
## - delete the settings.json one last time
## - close/free the DirAccess object
func after() -> void:
	test_dir.remove("settings.json")
	test_dir = null


#region Tests
## test__resolution_640x480 selects the resolution option _640x480 and checks that the proper
## settings are applied. In addition to testing the methods below, it also checks that the
## resolution enums and their indices match.
func test__resolution_640x480() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RES_640X480_EXP_PATH)
	var actual_dict : Dictionary
	var resolution_options : OptionButton
	var accept_button : Button
	var save_changes_button : Button
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	resolution_options = runner.find_child("ResolutionOptions")
	await utilities.move_to_element_and_click(runner, settings_component, resolution_options)
	runner.simulate_key_press(KEY_DOWN)
	await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	accept_button = runner.find_child("AcceptButton")
	await utilities.move_to_element_and_click(runner, settings_component, accept_button)
	save_changes_button = runner.find_child("SaveChangesButton")
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(640, 480))


#func test__resolution_timeout() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RESET_TIMEOUT_EXP_PATH)
	#var actual_dict : Dictionary
	#var reset_button : Button = runner.find_child("ResetDefaultButton")
	#var display_prompt : Control
	## Act
	#utilities.replace_test_settings_data(consts.TEST_RESET_TIMEOUT_DUMMY_PATH)
	#utilities.move_to_element_and_click(runner, settings_component, settings_label)
	#runner.set_mouse_position(reset_button.get_screen_position() + consts.BUTTON_OFFSET)
	#await runner.await_input_processed()
	#runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	#await runner.await_input_processed()
	## DisplayPrompt gets instantiated, now find it
	#display_prompt = runner.find_child("DisplayPrompt")
	## Assert
	#assert(display_prompt.visible)
	#await await_millis(16000)
	#assert(!display_prompt.visible)
	#assert_dict(actual_dict).is_equal(expected_dict)
#endregion


#region Test Helpers
#endregion
