extends Node

var options_data_path : String = ""
@onready var main_menu: Control = %MainMenu
@onready var settings: Control = %Settings
@onready var sfx_audio_stream: AudioStreamPlayer2D = %SFXAudioStream

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalEvents.MainMenuLabelPressed.connect(on_main_menu_label_clicked)


func on_main_menu_label_clicked(label_id):
	sfx_audio_stream.play()
	match label_id:
		GlobalEnums.MainMenuButtonID.SETTINGS:
			settings.visible = true
