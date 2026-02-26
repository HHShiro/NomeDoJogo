extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

func menu_pause():
	$Panel/Options.hide()
	$Back.hide()
	$Filtro.show()
	$Menu.show()
	$Panel/Audio.hide()
	$Panel/Controles.hide()


func options():
	$Back.show()
	$Filtro.hide()
	$Menu.hide()
	$Panel/Options.show()
	tween_pop($Panel/Options)

func controles():
	$Filtro.hide()
	$Menu.hide()
	$Panel/Options.hide()
	$Panel/Audio.hide()
	$Panel/Controles.show()
	tween_pop($Panel/Controles)

func audio():
	$Filtro.hide()
	$Menu.hide()
	$Panel/Options.hide()
	$Panel/Audio.show()
	$Panel/Controles.hide()
	tween_pop($Panel/Audio)

func tween_pop(panel):
	SoundManager.play_sfx(load("res://assets/sounds/sfx/button_menu_sound.wav"))
	panel.scale = Vector2(0.85,0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.tween_property(panel, "scale", Vector2(1,1), 0.5)

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS

func _input(event):
	if event.is_action_pressed("pause_menu"):
		toggle_pause()

func toggle_pause():
	ManipuladorPause.pause_all()
	visible = !visible
	if get_tree().paused:
		menu_pause()


func _on_resume_pressed() -> void:
	ManipuladorPause.pause_all()
	visible = false


func _on_back_main_menu_pressed() -> void:
	ManipuladorPause.pause_all()
	SaveData.gold += player.gold
	SaveData.set_and_save()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")


func _on_options_pressed() -> void:
	options()



func _on_audio_pressed() -> void:
	audio()


func _on_controles_pressed() -> void:
	controles()


func _on_back_pressed() -> void:
	menu_pause()
