extends Node2D

@onready var sfx_player: AudioStreamPlayer
@onready var music_player: AudioStreamPlayer
@export var hover_sound : AudioStream

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	
	get_tree().node_added.connect(on_node_added)
	
	connect_buttons_recursively(get_tree().root)

func play_sfx(sfx: AudioStream, randomize_pitch: bool = false):
	if sfx:
		sfx_player = AudioStreamPlayer.new()
		add_child(sfx_player)
		
		sfx_player.process_mode = Node.PROCESS_MODE_ALWAYS
		sfx_player.stream = sfx
		sfx_player.bus = "SFX"
		sfx_player.play()
		
		if randomize_pitch:
			sfx_player.pitch_scale = randf_range(0.85, 1.15)
		else:
			sfx_player.pitch_scale = 1
		
		sfx_player.finished.connect(sfx_player.queue_free)

func play_music(music: AudioStream):
	if music:
		music_player = AudioStreamPlayer.new()
		add_child(music_player)
		
		music_player.process_mode = Node.PROCESS_MODE_ALWAYS
		music_player.stream = music
		music_player.bus = "Music"
		music_player.play()
		music_player.finished.connect(music_player.play)
		
func pause_music():
	if music_player:
		music_player.stream_paused = true
		
func on_node_added(node: Node):
	if node is Button or node is TextureButton:
		connect_signals(node)

# Função recursiva que varre a árvore inteira procurando botões escondidos
func connect_buttons_recursively(node: Node):
	# Se for botão, conecta
	if node is Button or node is TextureButton:
		connect_signals(node)
	
	# Continua procurando nos filhos desse nó
	for child in node.get_children():
		connect_buttons_recursively(child)

# Função auxiliar para não repetir código e evitar erro de conexão duplicada
func connect_signals(node: Node):
	if not node.mouse_entered.is_connected(play_hover):
		node.mouse_entered.connect(play_hover)
		
			
func play_hover():
	play_sfx(hover_sound)
