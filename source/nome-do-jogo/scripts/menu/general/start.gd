extends Button


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/fases/primeira_fase.tscn")
	SoundManager.play_music(load("res://assets/music/BeepBox-Song.wav"))
