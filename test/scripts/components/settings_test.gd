# GdUnit generated TestSuite
class_name SettingsTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source : String = 'res://scripts/components/settings.gd'

#region Variables
# before()
var runner : GdUnitSceneRunner
var settings : Settings
var test_dir : DirAccess

var consts : SettingsTestConsts = SettingsTestConsts.new()
var utilities : SettingsTestUtilities = SettingsTestUtilities.new()
#endregion


## before any test, create the Settings object and add the filepaths for the test
func before() -> void:
	settings = auto_free(Settings.new(consts.test_parent_folder_path, consts.test_settings_file_path))
	test_dir = DirAccess.open(consts.test_settings_folder_path)


## before every test, reload the scene runner and change the settings.json reference
func before_test() -> void:
	runner = scene_runner(consts.test_settings_scene_path)
	var settings_scene : Settings = runner.invoke("find_child", "Settings")
	settings_scene.parent_folder_path = consts.test_parent_folder_path
	settings_scene.settings_file_path = consts.test_settings_file_path


## after every test, delete the settings.json generated from the test
func after_test() -> void:
	pass # test_dir.remove("settings.json")


## after all tests, close/free the DirAccess object
func after() -> void:
	test_dir = null


#region Tests
## test__open_settings() checks if the settings menu button opens the settings menu.
func test__open_settings() -> void:
	# Arrange
	var runner : GdUnitSceneRunner
	var settings_label : Label
	var settings_component : Settings
	# Act
	runner = scene_runner(consts.test_settings_scene_path)
	settings_label = runner.find_child("SettingsLabel")
	runner.set_mouse_position(settings_label.get_screen_position() + consts.button_offset)
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
	var expected_dict : Dictionary = utilities.get_json_data(consts.test_initialize_exp_path)
	var actual_dict : Dictionary
	# Act
	settings._initialize_settings()
	actual_dict = utilities.get_json_data(consts.test_settings_file_path)
	# Assert
	assert_dict(actual_dict).is_equal(expected_dict)


#func test__reset_to_default() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.test_initialize_exp_path)
	#var dummy_dict : Dictionary = utilities.get_json_data(consts.test_initialize_exp_path)
	#var actual_dict : Dictionary
	#var runner : GdUnitSceneRunner
	#utilities.replace_test_settings_data(consts.test_reset_dummy_path)
	## Act
	#runner = scene_runner(consts.test_settings_scene_path)
	#runner.invoke("on_main_menu_label_clicked", GlobalEnums.MainMenuButtonID.SETTINGS)
	## Assert
	#

#endregion
