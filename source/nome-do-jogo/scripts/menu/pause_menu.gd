extends CanvasLayer

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("pause_menu"):
		toggle_pause()

func toggle_pause():
	get_tree().paused = !get_tree().paused
	visible = get_tree().paused
	
func _on_resume_pressed() -> void:
	get_tree().paused = false
	visible = false


func _on_back_main_menu_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
