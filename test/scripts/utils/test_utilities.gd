# GdUnit generated TestSuite
class_name TestUtilities
extends Control
var consts : TestConsts = TestConsts.new()

#region Settings JSON Helpers
## get_json_data() retrieves the json data from a given file's path.
func get_json_data(json_file_path: String) -> Dictionary:
	var readfile : FileAccess = FileAccess.open(json_file_path, FileAccess.READ)
	var file_contents : String = readfile.get_as_text()
	var data : Dictionary = JSON.parse_string(file_contents)
	return data


## replace_test_settings_data() replaces the test settings.json's data with another json file's
## data.
func replace_test_settings_data(json_file_path: String) -> void:
	var dir : DirAccess = DirAccess.open(consts.TEST_SETTINGS_FOLDER_PATH)
	dir.copy(json_file_path, consts.TEST_SETTINGS_FILE_PATH)
#endregion


## move_to_element_and_click() is a coroutine that simulates moving the mouse to a Control node and
## left clicking it.
## NOTE: If you change an element's position/scale, you must wait one frame to get the new values!
func move_to_element_and_click(runner: GdUnitSceneRunner, canvas_parent: CanvasItem, element: Control) -> void:
	var new_mouse_position : Vector2 = get_adjusted_screen_position(canvas_parent, element) + (element.size / 2)
	runner.set_mouse_pos(new_mouse_position)
	await runner.await_input_processed()
	runner.simulate_mouse_button_pressed(MOUSE_BUTTON_LEFT)
	await runner.await_input_processed()
	await runner.simulate_frames(1)


#region Scene Runner Helpers
 ## add_offset_to_pos() returns a given position + button offset.
func add_button_offset_to_pos(position: Vector2) -> Vector2:
	return position + consts.BUTTON_OFFSET
 
 
 ## get_adjusted_screen_position() returns the position of a Control based on the screen position.
 ## The value is affected by the viewport size.
func get_adjusted_screen_position(canvas_parent: CanvasItem, element: Control) -> Vector2:
	return canvas_parent.get_viewport_transform() * canvas_parent.get_global_transform() * element.global_position
 #endregion
