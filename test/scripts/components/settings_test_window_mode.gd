# GdUnit generated TestSuite
class_name SettingsTestWindowMode
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
var wm_consts : TestWindowModeConsts = TestWindowModeConsts.new()
var utilities : TestUtilities = TestUtilities.new()
#endregion


## before any test, set up DirAccess
@warning_ignore('unused_parameter')
func before(
	do_skip : bool=DisplayServer.get_name().contains("headless"),
	skip_reason : String="Cannot run scene runner tests in headless mode."
) -> void:
	print("(SETTINGS_TEST_WINDOW_MODE) GET NAME: %s" % DisplayServer.get_name())
	print("DOES IT CONTAIN HEADLESS? : %s" % DisplayServer.get_name().contains("headless"))
	test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)


## before every test:
## - delete the test settings.json if one exists
func before_test() -> void:
	test_dir.remove("settings.json")


## after all tests:
## - delete the settings.json one last time
## - close/free the DirAccess object
func after() -> void:
	test_dir.remove("settings.json")
	test_dir = null


#region Tests
## test__window_mode_fullscreen() selects the window mode option "Fullscreen" and checks that the
## proper settings are applied.
func test__window_mode_fullscreen() -> void:
	_load_scene_and_nodes()
	await _window_mode_picker(
		wm_consts.TEST_WM_FULLSCREEN_EXP_PATH,
		GlobalEnums.WindowModeSettingsID.FULLSCREEN,
		DisplayServer.WindowMode.WINDOW_MODE_FULLSCREEN,
		false
	)

## test__window_mode_windowed() selects the window mode option "Windowed" and checks that the
## proper settings are applied.
func test__window_mode_windowed() -> void:
	utilities.replace_test_settings_data(wm_consts.TEST_WM_WINDOWED_DUMMY_PATH)
	_load_scene_and_nodes()
	await _window_mode_picker(
		wm_consts.TEST_WM_WINDOWED_EXP_PATH,
		GlobalEnums.WindowModeSettingsID.WINDOWED,
		DisplayServer.WindowMode.WINDOW_MODE_WINDOWED,
		false
	)

## test__window_mode_borderless() selects the window mode option "Borderless Windowed" and checks
## that the proper settings are applied.
func test__window_mode_borderless() -> void:
	_load_scene_and_nodes()
	await _window_mode_picker(
		wm_consts.TEST_WM_BORDERLESS_EXP_PATH,
		GlobalEnums.WindowModeSettingsID.BORDERLESS_WINDOWED,
		DisplayServer.WindowMode.WINDOW_MODE_WINDOWED,
		true
	)
#endregion


#region Test Helpers
## _load_scene_and_nodes() loads the test scene and gets the initial nodes.
## - delete the test settings.json if one exists
## - reload the scene runner and change the settings.json reference
## - find relevant settings nodes
func _load_scene_and_nodes() -> void:
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")


## _window_mode_picker() is used by all window mode tests. It selects a given window mode and
## compares the settings and window mode to a given file output and window mode.
## NOTE: This will fail if the window mode is already selected!
func _window_mode_picker(
	exp_output_path: String,
	window_mode_setting_enum: GlobalEnums.WindowModeSettingsID,
	exp_window_mode: DisplayServer.WindowMode,
	exp_border_flag: bool
) -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(exp_output_path)
	var actual_dict : Dictionary
	var window_mode_options : OptionButton
	var save_changes_button : Button
	
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)

	# click the window mode option
	window_mode_options = runner.find_child("FullscreenOptions")
	await utilities.move_to_element_and_click(runner, settings_component, window_mode_options)

	# navigate through the window mode options by pressing down, then selecting it with "enter"
	for i : int in range(window_mode_setting_enum + 1):
		runner.simulate_key_press(KEY_DOWN)
		await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	
	# save the changes
	save_changes_button = runner.find_child("SaveChangesButton")
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)

	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_that(DisplayServer.window_get_mode()).is_equal(exp_window_mode)
	assert_that(DisplayServer.window_get_flag(DisplayServer.WINDOW_FLAG_BORDERLESS)).is_equal(exp_border_flag)
#endregion
