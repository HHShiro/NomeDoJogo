extends CanvasLayer

var pause_duplicado:= false

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("pause_menu"):
		toggle_pause()

func toggle_pause():
	if get_tree().paused and !visible:
		pause_duplicado = true
		visible = true
	else:
		if !pause_duplicado:
			get_tree().paused = !get_tree().paused
			visible = get_tree().paused
		else:
			pause_duplicado = false
			visible = false
	
func _on_resume_pressed() -> void:
	if !pause_duplicado:
		get_tree().paused = false
	pause_duplicado = false
	visible = false


func _on_back_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
