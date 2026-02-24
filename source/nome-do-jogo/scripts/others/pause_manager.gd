extends Node2D # Ou Node
class_name PauseManager

var paused := false      
var paused_all := false  

var current_interactable = null

func pause(interactable_node = null):
	if paused_all:
		return

	paused = !paused
	get_tree().paused = paused
	
	if paused and interactable_node:
		current_interactable = interactable_node
	elif !paused:
		current_interactable = null
	
	print("Simples Pause: ", paused)

func pause_all():
	paused_all = !paused_all
	
	if SoundManager.music_player:
		SoundManager.music_player.stream_paused = paused_all

	if paused_all:
		if paused:
			if is_instance_valid(current_interactable):
				current_interactable.process_mode = Node.PROCESS_MODE_DISABLED
		else:
			get_tree().paused = true
			
	else:
		if paused:
			if is_instance_valid(current_interactable):
				current_interactable.process_mode = Node.PROCESS_MODE_ALWAYS
		else:
			get_tree().paused = false

	print("Pause All (ESC): ", paused_all)
