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
	#settings = auto_free(Settings.new(consts.test_parent_folder_path, consts.test_settings_file_path))
	#display_prompt = settings.display_prompt
	#test_dir = DirAccess.open(consts.test_settings_folder_path)
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
	#var expected_dict : Dictionary = utilities.get_json_data(consts.test_res_640x480_exp_path)
	#var actual_dict : Dictionary
	## Act
	## settings._on_resolution_option_item_selected(GlobalEnums.DisplaySettingsID._640x480)
	#settings._change_resolution(GlobalEnums.DisplaySettingsID._640x480)
	#display_prompt._on_accept_button_pressed()
	#settings._on_save_changes_button_pressed()
	#actual_dict = utilities.get_json_data(consts.test_settings_file_path)
	## Assert
	#assert_dict(actual_dict).is_equal(expected_dict)
	#assert_that(DisplayServer.window_get_size()).is_equal(Vector2i(640, 480))
	#
	#
##endregion
