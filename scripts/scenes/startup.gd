extends Node

@onready var main_menu: Control = %MainMenu
@onready var settings: Control = %Settings
@onready var music_audio_stream: AudioStreamPlayer2D = %MusicAudioStream
@onready var sfx_audio_stream: AudioStreamPlayer2D = %SFXAudioStream

var music_position : float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
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
