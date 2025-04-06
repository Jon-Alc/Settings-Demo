# TODO: Use the scene runner for this

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
## before()
#var settings : Settings
#var test_dir : DirAccess
#var display_prompt : DisplayPrompt
#
#var consts : TestSettingsConsts = SettingsTestConsts.new()
#var utilities : TestSettingsUtilities = SettingsTestUtilities.new()
##endregion
#
#
### before any test, create the Settings object and add the filepaths for the test
#func before() -> void:
	#settings = auto_free(Settings.new(consts.TEST_PARENT_FOLDER_PATH, consts.TEST_SETTINGS_FILE_PATH))
	#display_prompt = settings.display_prompt
	#test_dir = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)
#
#
### after every test, delete the settings.json generated from the test
#func after_test() -> void:
	#test_dir.remove("settings.json")
#
#
### after all tests, close/free the DirAccess object
#func after() -> void:
	#test_dir = null
#
#
##region Tests
### test__resolution_640x480 selects the resolution option _640x480 and checks that the proper
### settings are applied. In addition to testing the methods below, it also checks that the
### resolution enums and their indices match.
### Methods tested:
### - settings._on_resolution_option_item_selected()
### - GlobalEnums.int_to_display_settings_id()
### - settings._change_resolution()
### - settings._center_window()
### - display_prompt.timed_prompt()
### - display_prompt._on_accept_button_pressed()
### - settings._display_prompt_accept_resolution()
### - settings._on_save_changes_button_pressed()
### - settings._save_settings()
#func test__resolution_640x480() -> void:
	## Arrange
	#var expected_dict : Dictionary = utilities.get_json_data(consts.TEST_RES_640X480_EXP_PATH)
	#var actual_dict : Dictionary
	## Act
	## settings._on_resolution_option_item_selected(GlobalEnums.DisplaySettingsID._640x480)
	#settings._change_resolution(GlobalEnums.DisplaySettingsID._640x480)
	#display_prompt._on_accept_button_pressed()
	#settings._on_save_changes_button_pressed()
	#actual_dict = utilities.get_json_data(consts.TEST_SETTINGS_FILE_PATH)
	## Assert
	#assert_dict(actual_dict).is_equal(expected_dict)
	#assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(640, 480))
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
	#runner.set_mouse_position(settings_label.get_screen_position() + consts.BUTTON_OFFSET)
	#await runner.await_input_processed()
	#runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	#await runner.await_input_processed()
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
