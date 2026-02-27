extends Node2D

@export var animation_player: AnimationPlayer
@export var autoplay: bool = false

func _ready():
	#SoundManager.pause_music()
	var bus_index: int = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, -8)

func fim():
	get_tree().change_scene_to_file("res://scenes/fases/end_scene_test.tscn")
