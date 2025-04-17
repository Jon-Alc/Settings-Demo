# GdUnit generated TestSuite
class_name SettingsTestVsync
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
var vsync_consts : TestVsyncConsts = TestVsyncConsts.new()
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
## test__vsync_on() enables vsync and checks that the proper settings are applied.
func test__vsync_on() -> void:
	utilities.replace_test_settings_data(vsync_consts.TEST_VSYNC_ON_DUMMY_PATH)
	await _load_scene_and_nodes()
	await _vsync_picker(
		vsync_consts.TEST_VSYNC_ON_EXP_PATH,
		GlobalEnums.VSyncSettingsID.ON,
		DisplayServer.VSyncMode.VSYNC_ENABLED
	)

## test__vsync_off() disables vsync and checks that the proper settings are applied.
func test__vsync_off() -> void:
	await _load_scene_and_nodes()
	await _vsync_picker(
		vsync_consts.TEST_VSYNC_OFF_EXP_PATH,
		GlobalEnums.VSyncSettingsID.OFF,
		DisplayServer.VSyncMode.VSYNC_DISABLED
	)

## test__vsync_adaptive() enables the "Adaptive" option for vsync and checks that the proper
## settings are applied.
func test__vsync_adaptive() -> void:
	await _load_scene_and_nodes()
	await _vsync_picker(
		vsync_consts.TEST_VSYNC_ADAPTIVE_EXP_PATH,
		GlobalEnums.VSyncSettingsID.ADAPTIVE,
		DisplayServer.VSyncMode.VSYNC_ADAPTIVE
	)


## TODO: Load invalid vsync option; typo string in settings.json
#endregion


#region Test Helpers
## _load_scene_and_nodes() loads the test scene and gets the initial nodes.
func _load_scene_and_nodes() -> void:
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	await runner.simulate_frames(1)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")


## _vsync_picker() is used by all vsync tests. It selects a given vsync option and
## compares the settings and vsync to a given file output and vsync enum.
## NOTE: This will fail if the vsync option is already selected!
func _vsync_picker(
	exp_output_path: String,
	vsync_setting_enum: GlobalEnums.VSyncSettingsID,
	exp_vsync_mode: DisplayServer.VSyncMode
) -> void:
	# Arrange
	var expected_dict : Dictionary = utilities.get_json_data(exp_output_path)
	var actual_dict : Dictionary
	var vsync_options : OptionButton
	var save_changes_button : Button
	
	# Act
	# go to settings
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)

	# click the vsync option
	vsync_options = runner.find_child("VSyncOptions")
	await utilities.move_to_element_and_click(runner, settings_component, vsync_options)

	# navigate through the vsync options by pressing down, then selecting it with "enter"
	for i : int in range(vsync_setting_enum + 1):
		runner.simulate_key_press(KEY_DOWN)
		await runner.await_input_processed()
	runner.simulate_key_press(KEY_ENTER)
	await runner.await_input_processed()
	await runner.simulate_frames(1)
	
	# save the changes
	save_changes_button = runner.find_child("SaveChangesButton")
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	await runner.simulate_frames(1)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)

	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)
	print("Current vsync mode %s is expected to be %s" % [DisplayServer.window_get_vsync_mode(), exp_vsync_mode])
	assert_that(DisplayServer.window_get_vsync_mode()).is_equal(exp_vsync_mode)
#endregion
