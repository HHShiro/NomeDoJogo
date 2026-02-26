extends Node2D # Ou Node
class_name PauseManager

var paused := false      
var paused_all := false  

var current_interactable = null
var interaction_queue : Array[Node] = []

func open_menu(node_to_open: Node):
	if paused_all: return

	if current_interactable != null and current_interactable != node_to_open:
		if node_to_open not in interaction_queue:
			interaction_queue.append(node_to_open)
			node_to_open.hide()
		return
	
	paused = true
	get_tree().paused = true
	current_interactable = node_to_open
	
	current_interactable.show()
	print("Menu Aberto: ", node_to_open.name)
	
	
func close_menu(node_to_close: Node):
	if paused_all: return
	
	node_to_close.hide()
	
	if interaction_queue.size() > 0:
		var next_menu = interaction_queue.pop_front()
		
		current_interactable = next_menu
		current_interactable.show()
		print("Fila andou. Abrindo: ", next_menu.name)
		
	else:
		current_interactable = null
		paused = false
		get_tree().paused = false
		print("Novo Jogo")

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
		get_tree().paused = true
		if is_instance_valid(current_interactable):
			current_interactable.visible = false
			current_interactable.process_mode = Node.PROCESS_MODE_DISABLED
	else:
		if is_instance_valid(current_interactable):
			current_interactable.visible = true
			current_interactable.process_mode = Node.PROCESS_MODE_ALWAYS
			get_tree().paused = true 
		else:
			get_tree().paused = false

	print("Pause All (ESC): ", paused_all)
