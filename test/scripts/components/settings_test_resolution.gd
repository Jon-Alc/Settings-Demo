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
var res_consts : TestResolutionConsts = TestResolutionConsts.new()
var utilities : TestUtilities = TestUtilities.new()
#endregion


## before any test, skip the suite if the window is embedded
## otherwise, set up DirAccess
@warning_ignore('unused_parameter')
func before(
	do_skip : bool=DisplayServer.get_name().contains("headless"),
	skip_reason : String="Cannot run scene runner tests in headless mode."
) -> void:
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
## test__resolution_640x480() selects the resolution option _640x480 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_640x480(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(640, 480),
	skip_reason : String="Monitor size does not meet requirements for test (min: >640x480)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_640X480_EXP_PATH,
		GlobalEnums.DisplaySettingsID._640x480,
		Vector2i(640, 480)
	)


## test__resolution_800x600() selects the resolution option _800x600 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_800x600(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(800, 600),
	skip_reason : String="Monitor size does not meet requirements for test (min: >800x600)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_800X600_EXP_PATH,
		GlobalEnums.DisplaySettingsID._800x600,
		Vector2i(800, 600)
	)


## test__resolution_1366x768() selects the resolution option _1366x768 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_1366x768(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(1366, 768),
	skip_reason : String="Monitor size does not meet requirements for test (min: >1366x768)."
) -> void:
	utilities.replace_test_settings_data(res_consts.TEST_RES_1366X768_DUMMY_PATH)
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_1366X768_EXP_PATH,
		GlobalEnums.DisplaySettingsID._1366x768,
		Vector2i(1366, 768)
	)


## test__resolution_1600x900() selects the resolution option _1600x900 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_1600x900(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(1600, 900),
	skip_reason : String="Monitor size does not meet requirements for test (min: >1600x900)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_1600X900_EXP_PATH,
		GlobalEnums.DisplaySettingsID._1600x900,
		Vector2i(1600, 900)
	)


## test__resolution_1920x1080() selects the resolution option _1920x1080 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_1920x1080(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(1920, 1080),
	skip_reason : String="Monitor size does not meet requirements for test (min: >1920x1080)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_1920X1080_EXP_PATH,
		GlobalEnums.DisplaySettingsID._1920x1080,
		Vector2i(1920, 1080)
	)


## test__resolution_1920x1200() selects the resolution option _1920x1200 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_1920x1200(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(1920, 1200),
	skip_reason : String="Monitor size does not meet requirements for test (min: >1920x1200)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_1920X1200_EXP_PATH,
		GlobalEnums.DisplaySettingsID._1920x1200,
		Vector2i(1920, 1200)
	)


## test__resolution_2560x1440() selects the resolution option _2560x1440 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_2560x1440(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(2560, 1440),
	skip_reason : String="Monitor size does not meet requirements for test (min: >2560x1440)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_2560X1440_EXP_PATH,
		GlobalEnums.DisplaySettingsID._2560x1440,
		Vector2i(2560, 1440)
	)


## test__resolution_2560x1600() selects the resolution option _2560x1600 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_2560x1600(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(2560, 1600),
	skip_reason : String="Monitor size does not meet requirements for test (min: >2560x1600)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_2560X1600_EXP_PATH,
		GlobalEnums.DisplaySettingsID._2560x1600,
		Vector2i(2560, 1600)
	)


## test__resolution_3840x2160() selects the resolution option _3840x2160 and checks that the proper
## settings are applied.
@warning_ignore('unused_parameter')
func test__resolution_3840x2160(
	do_skip: bool=DisplayServer.screen_get_size() <= Vector2i(3840, 2160),
	skip_reason : String="Monitor size does not meet requirements for test (min: >3840x2160)."
) -> void:
	await _load_scene_and_nodes()
	await _select_resolution_test_helper(
		res_consts.TEST_RES_3840X2160_EXP_PATH,
		GlobalEnums.DisplaySettingsID._3840x2160,
		Vector2i(3840, 2160)
	)


## test_resolution_timeout() tests that the display prompt reverts to original settings when the
## display prompt times out.
func test__resolution_timeout() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(res_consts.TEST_RESET_TIMEOUT_EXP_PATH)
	var actual_dict : Dictionary
	var resolution_options : OptionButton
	var display_prompt : Control
	await _load_scene_and_nodes()
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	
	# pick any resolution to bring up the DisplayPrompt
	resolution_options = runner.find_child("ResolutionOptions")
	await utilities.move_to_element_and_click(runner, settings_component, resolution_options)
	runner.simulate_key_press(KEY_DOWN)
	await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	display_prompt = runner.find_child("DisplayPrompt")
	
	# Assert
	assert_bool(display_prompt.visible).is_true()
	await await_millis(16000)
	assert_that(display_prompt).is_null()
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(1366, 768))


## test_resolution_cancel() tests that the display prompt reverts to original settings when the
## cancel button is clicked in the display prompt.
func test__resolution_cancel() -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(res_consts.TEST_RESET_CANCEL_EXP_PATH)
	var actual_dict : Dictionary
	var resolution_options : OptionButton
	var display_prompt : Control
	var cancel_button : Button
	await _load_scene_and_nodes()
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	
	# pick any resolution to bring up the DisplayPrompt
	resolution_options = runner.find_child("ResolutionOptions")
	await utilities.move_to_element_and_click(runner, settings_component, resolution_options)
	runner.simulate_key_press(KEY_DOWN)
	await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	display_prompt = runner.find_child("DisplayPrompt")
	cancel_button = display_prompt.find_child("CancelButton")
	
	# Assert
	assert_bool(display_prompt.visible).is_true()
	await utilities.move_to_element_and_click(runner, settings_component, cancel_button)
	assert_that(display_prompt).is_null()
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(1366, 768))
	
	
## TODO: Load invalid resolution; put an invalid string in settings.json
#endregion


#region Test Helpers
## _load_scene_and_nodes() loads the test scene and gets the initial nodes.
## - delete the test settings.json if one exists
## - reload the scene runner and change the settings.json reference
## - find relevant settings nodes
func _load_scene_and_nodes() -> void:
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")


## _select_resolution_test_helper() is used by resolution tests that select a given resolution and
## save it. It compares the settings and window size to a given file output and window size.
## NOTE: This will fail if the desired resolution is already selected!
func _select_resolution_test_helper(
	exp_output_path: String,
	display_setting_enum: GlobalEnums.DisplaySettingsID,
	exp_window_size: Vector2i
) -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(exp_output_path)
	var actual_dict : Dictionary
	var save_changes_button : Button
	
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)

	# select the resolution
	await _resolution_picker(display_setting_enum)
	
	# save changes and exit settings component
	save_changes_button = runner.find_child("SaveChangesButton")
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_that(DisplayServer.window_get_size()).is_equal(exp_window_size)


## _resolution_picker() selects a given resolution.
## NOTE: This will fail if the resolution is already selected!
func _resolution_picker(display_setting_enum: GlobalEnums.DisplaySettingsID) -> void:
	# click the resolution option
	var resolution_options : OptionButton = runner.find_child("ResolutionOptions")
	await utilities.move_to_element_and_click(runner, settings_component, resolution_options)

	# navigate through the resolution options by pressing down, then selecting it with "enter"
	for i : int in range(display_setting_enum + 1):
		runner.simulate_key_press(KEY_DOWN)
		await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	
	# save the changes
	var accept_button : Button = runner.find_child("AcceptButton")
	await utilities.move_to_element_and_click(runner, settings_component, accept_button)
#endregion
