extends Node2D

#region Variables
@export var main_menu_screen_scene: PackedScene = preload("res://nodes/scenes/main_menu_screen.tscn")
@onready var main_menu_screen: Node2D

var music_position : float
#endregion


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_screen = main_menu_screen_scene.instantiate().pass_dependencies(
		GlobalConsts.SAVE_PATH,
		GlobalConsts.SETTINGS_FILE_PATH
	)
	add_child(main_menu_screen)
