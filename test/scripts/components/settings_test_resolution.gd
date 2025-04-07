## GdUnit generated TestSuite
#class_name SettingsTestResolution
#extends GdUnitTestSuite
#@warning_ignore('unused_parameter')
#@warning_ignore('return_value_discarded')
#
## TestSuite generated from
#const __source : String = 'res://scripts/components/settings.gd'
#
##region Variables
#var test_dir : DirAccess
#var runner : GdUnitSceneRunner
#var settings_label : Label
#var settings_component : Control
#
#var consts : TestConsts = TestConsts.new()
#var utilities : TestUtilities = TestUtilities.new()
##endregion
#
#
### before any test, create the Settings object and add the filepaths for the test
#func before() -> void:
	#test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)
#
#
### before every test:
### - delete the test settings.json if one exists
### - reload the scene runner and change the settings.json reference
### - find relevant settings nodes
#func before_test() -> void:
	#test_dir.remove("settings.json")
	#runner = scene_runner(consts.TEST_STARTUP_SCENE_PATH)
	#settings_label = runner.find_child("SettingsLabel")
	#settings_component = runner.find_child("Settings")
	#
	#
### after all tests:
### - delete the settings.json one last time
### - close/free the DirAccess object
#func after() -> void:
	#test_dir.remove("settings.json")
	#test_dir = null
#
#
##region Tests
### test__resolution_640x480 selects the resolution option _640x480 and checks that the proper
### settings are applied. In addition to testing the methods below, it also checks that the
### resolution enums and their indices match.
#func test__resolution_640x480() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RES_640X480_EXP_PATH)
	#var actual_dict : Dictionary
	#var resolution_options : OptionButton
	## Act
	#move_to_element_and_click(settings_label)
	#runner.set_mouse_pos(utilities.add_button_offset_to_pos(resolution_options.get_screen_position()))
	#await runner.await_input_processed()
	#runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	#await runner.await_input_processed()
	#actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	## Assert
	#assert_dict(actual_dict).is_equal(expected_dict)
	#assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(640, 480))
	#
	#
#
#func test__resolution_timeout() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RESET_TIMEOUT_EXP_PATH)
	#var actual_dict : Dictionary
	#var reset_button : Button = runner.find_child("ResetDefaultButton")
	#var display_prompt : Control
	## Act
	#utilities.replace_test_settings_data(consts.TEST_RESET_TIMEOUT_DUMMY_PATH)
	#move_to_element_and_click(settings_label)
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
##endregion
#
#
##region Test Helpers
#func move_to_element_and_click(element: Control) -> void:
	#runner.set_mouse_pos(utilities.add_button_offset_to_pos(element.get_screen_position()))
	#await runner.await_input_processed()
	#runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	#await runner.await_input_processed()
##endregion
