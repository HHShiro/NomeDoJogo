extends Node2D
class_name PauseManager

var paused:= false
var paused_all:= false

func pause():
	if !paused_all:
		get_tree().paused = !get_tree().paused
		paused = !paused
		print("Valor de Paused: ", paused)
	
func pause_all():
	SoundManager.music_player.stream_paused = !SoundManager.music_player.stream_paused
	if !paused:
		get_tree().paused = !get_tree().paused
		paused_all = !paused_all
		print("Valor de Paused All: ", paused_all)
