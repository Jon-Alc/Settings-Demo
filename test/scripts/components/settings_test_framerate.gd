# GdUnit generated TestSuite
class_name SettingsTestFramerate
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
var save_changes_button : Button
var actual_dict : Dictionary
var expected_dict : Dictionary

var consts : TestConsts = TestConsts.new()
var framerate_consts : TestFramerateConsts = TestFramerateConsts.new()
var utilities : TestUtilities = TestUtilities.new()
#endregion


## before any test, set up DirAccess
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
## test__framerate_change() checks that the framerate spinbox can change values and affect the
## game's framerate.
func test__framerate_change() -> void:
	# Arrange
	expected_dict = utilities.get_json_data(framerate_consts.TEST_FRAMERATE_CHANGE_EXP_PATH)
	await _load_scene_and_nodes()
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var spinbox : SpinBox = runner.find_child("FramerateSpinBox")
	await utilities.move_to_element_and_click(runner, settings_component, spinbox)
	
	## these keys work
	# runner.simulate_key_pressed(KEY_BACKSPACE)
	# runner.simulate_key_pressed(KEY_BACKSPACE)
	# await runner.await_input_processed()
	## these don't?
	# runner.simulate_key_pressed(KEY_APOSTROPHE)
	# runner.simulate_key_pressed(KEY_M)
	# runner.simulate_key_pressed(KEY_1)
	# runner.simulate_key_pressed(KEY_2)
	# runner.simulate_key_pressed(KEY_0)
	# await runner.await_input_processed()
	
	# can use mouse wheel instead
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_WHEEL_UP)
	await runner.await_input_processed()
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_int(int(spinbox.value)).is_equal(Engine.max_fps)


## test__framerate_spinbox_upper_cap() checks that the framerate spinbox caps out at 999.
func test__framerate_spinbox_upper_cap() -> void:
	# Arrange
	expected_dict = utilities.get_json_data(framerate_consts.TEST_FRAMERATE_UPPER_CAP_EXP_PATH)
	await _load_scene_and_nodes()
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var spinbox : SpinBox = runner.find_child("FramerateSpinBox")
	await utilities.move_to_element_and_click(runner, settings_component, spinbox)
	
	while spinbox.value < 999:
		runner.simulate_mouse_button_press(MOUSE_BUTTON_WHEEL_UP)
		await runner.await_input_processed()
		
	await await_millis(1000)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_WHEEL_UP)
	await runner.await_input_processed()
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_int(int(spinbox.value)).is_equal(999)
	
	
## test__framerate_spinbox_upper_cap() checks that the framerate spinbox has a minimum of 30.
func test__framerate_spinbox_lower_cap() -> void:
	# Arrange
	expected_dict = utilities.get_json_data(framerate_consts.TEST_FRAMERATE_LOWER_CAP_EXP_PATH)
	await _load_scene_and_nodes()
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var spinbox : SpinBox = runner.find_child("FramerateSpinBox")
	await utilities.move_to_element_and_click(runner, settings_component, spinbox)
	
	while spinbox.value > 30:
		runner.simulate_mouse_button_press(MOUSE_BUTTON_WHEEL_DOWN)
		await runner.await_input_processed()
		
	await await_millis(1000)
	runner.simulate_mouse_button_release(MOUSE_BUTTON_WHEEL_DOWN)
	await runner.await_input_processed()
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	assert_int(int(spinbox.value)).is_equal(30)


## TODO: Load invalid framerate; <30 and >999
#endregion


#region Test Helpers
## _load_scene_and_nodes() loads the test scene and gets the nodes.
func _load_scene_and_nodes() -> void:
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")
	save_changes_button = runner.find_child("SaveChangesButton")
#endregion
