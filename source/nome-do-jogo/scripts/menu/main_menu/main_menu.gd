extends Control

func _input(event):
	if Input.is_action_just_pressed("toggle_fullscreen"):
		var current_mode = DisplayServer.window_get_mode()
		if current_mode == DisplayServer.WINDOW_MODE_WINDOWED or current_mode == DisplayServer.WINDOW_MODE_MAXIMIZED:
			# troca pra fullscreen exclusivo
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		elif current_mode == DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN:
			# volta pra windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _ready() -> void:
	if SoundManager.music_player:
		SoundManager.music_player.queue_free()
	menu()

func _on_upgrades_pressed() -> void:
	skill_tree()


func _on_bestiary_pressed() -> void:
	bestiario()


func menu():
	$Menu.show()
	$SkillTree.hide()
	$Bestiario.hide()
	$Gold.hide()
	$Back.hide()
	$Options.hide()
	$Audio.hide()
	$Controles.hide()
	tween_pop($Menu)

func skill_tree():
	$SkillTree.show()
	$Menu.hide()
	$Back.show()
	await tween_pop($SkillTree)
	$Gold.show()
	
func bestiario():
	$Bestiario.show()
	$Menu.hide()
	$Back.show()
	tween_pop($Bestiario)
	$Gold.show()

func options():
	$Options.show()
	$Back.show()
	$Menu.hide()
	tween_pop($Options)
	$Gold.hide()

func controles():
	$Options.hide()
	$Back.show()
	$Menu.hide()
	$Gold.hide()
	$Audio.hide()
	$Controles.show()
	tween_pop($Controles)

func audio():
	$Options.hide()
	$Back.show()
	$Menu.hide()
	$Gold.hide()
	$Audio.show()
	$Controles.hide()
	tween_pop($Audio)

func _on_back_pressed() -> void:
	menu()

func tween_pop(panel):
	SoundManager.play_sfx(load("res://assets/sounds/sfx/button_menu_sound.wav"))
	panel.scale = Vector2(0.85,0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.tween_property(panel, "scale", Vector2(1,1), 0.5)


func _on_options_pressed() -> void:
	options()


func _on_audio_pressed() -> void:
	audio()


func _on_controles_pressed() -> void:
	controles()
