# GdUnit generated TestSuite
class_name SettingsTestAudio
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
var original_dict : Dictionary
var actual_dict : Dictionary

var consts : TestConsts = TestConsts.new()
var audio_consts : TestAudioConsts = TestAudioConsts.new()
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
## test__audio_master() checks that the slider affects the master audio bus in Godot.
func test__audio_master() -> void:
	# Arrange
	await _load_scene_and_shared(audio_consts.TEST_AUDIO_MASTER_EXP_PATH)
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var master_slider : HSlider = runner.find_child("MasterVolumeSlider")
	await utilities.move_to_element_and_click(runner, settings_component, master_slider)
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	var master_volume : float = AudioServer.get_bus_volume_linear(GlobalEnums.AudioBusIndex.MASTER)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_int(int(master_slider.value)).is_equal(int(master_volume * 100))
	assert_int(int(master_volume)).is_not_equal(75)
	assert_dict(actual_dict).is_not_equal(original_dict)


## test__audio_music() checks that the slider affects the music audio bus in Godot.
func test__audio_music() -> void:
	# Arrange
	await _load_scene_and_shared(audio_consts.TEST_AUDIO_MUSIC_EXP_PATH)
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var music_slider : HSlider = runner.find_child("MusicVolumeSlider")
	await utilities.move_to_element_and_click(runner, settings_component, music_slider)
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	var music_volume : float = AudioServer.get_bus_volume_linear(GlobalEnums.AudioBusIndex.MUSIC)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_int(int(music_slider.value)).is_equal(int(music_volume * 100))
	assert_int(int(music_volume)).is_not_equal(75)
	assert_dict(actual_dict).is_not_equal(original_dict)


## test__audio_sfx() checks that the slider affects the sfx audio bus in Godot.
func test__audio_sfx() -> void:
	# Arrange
	await _load_scene_and_shared(audio_consts.TEST_AUDIO_SFX_EXP_PATH)
	# Act
	await utilities.move_to_element_and_click(runner, settings_component, settings_label)
	var sfx_slider : HSlider = runner.find_child("SFXVolumeSlider")
	await utilities.move_to_element_and_click(runner, settings_component, sfx_slider)
	await utilities.move_to_element_and_click(runner, settings_component, save_changes_button)
	var sfx_volume : float = AudioServer.get_bus_volume_linear(GlobalEnums.AudioBusIndex.SFX)
	actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	# Assert
	assert_int(int(sfx_slider.value)).is_equal(int(sfx_volume * 100))
	assert_int(int(sfx_volume)).is_not_equal(75)
	assert_dict(actual_dict).is_not_equal(original_dict)
#endregion


#region Test Helpers
## _load_scene_and_shared() loads the test scene and gets the shared nodes.
func _load_scene_and_shared(orig_output_path : String) -> void:
	runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	DisplayServer.window_set_size(Vector2(1366, 768))
	original_dict = utilities.get_json_data(orig_output_path)
	await runner.simulate_frames(1)
	main_menu = runner.find_child("MainMenu")
	settings_label = main_menu.find_child("SettingsLabel")
	settings_component = runner.find_child("Settings")
	save_changes_button = runner.find_child("SaveChangesButton")
#endregion
