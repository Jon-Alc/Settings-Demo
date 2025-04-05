class_name MainMenuScreen
extends Node

@export var main_menu_component: PackedScene = preload("res://nodes/components/main_menu.tscn")
@export var settings_component: PackedScene = preload("res://nodes/components/settings.tscn")
@export var ui: Control
@export var music_audio_stream: AudioStreamPlayer2D
@export var sfx_audio_stream: AudioStreamPlayer2D

var main_menu: Control
var settings: Settings

var settings_parent_folder_path: String
var settings_file_path: String

var music_position : float

## pass_dependencies() is meant to be used after an instance of this is instantiated. It passes the
## dependencies for this node's script.
func pass_dependencies(given_parent_folder_path: String=GlobalConsts.SAVE_PATH,
given_settings_file_path: String=GlobalConsts.SETTINGS_FILE_PATH) -> MainMenuScreen:
	main_menu = main_menu_component.instantiate()
	settings = settings_component.instantiate().pass_dependencies(
		sfx_audio_stream, given_parent_folder_path, given_settings_file_path)
	settings.visible = false
	return self


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	ui.add_child(main_menu)
	ui.add_child(settings)
	
	GlobalEvents.MainMenuLabelPressed.connect(on_main_menu_label_clicked)
	get_window().focus_exited.connect(on_window_focus_exited)
	get_window().focus_entered.connect(on_window_focus_entered)


func on_main_menu_label_clicked(label_id: GlobalEnums.MainMenuButtonID) -> void:
	sfx_audio_stream.play()
	match label_id:
		GlobalEnums.MainMenuButtonID.SETTINGS:
			settings.visible = true


func on_window_focus_exited() -> void:
	if not settings.play_in_bg_setting:
		get_tree().paused = true
		music_position = music_audio_stream.get_playback_position()
		music_audio_stream.stop()


func on_window_focus_entered() -> void:
	if not settings.play_in_bg_setting:
		get_tree().paused = false
		music_audio_stream.play(music_position)
