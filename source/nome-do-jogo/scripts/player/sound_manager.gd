extends Node2D

@onready var sfx_player: AudioStreamPlayer

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
