extends CanvasLayer

@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	visible = false
	process_mode = Node.PROCESS_MODE_ALWAYS
	
func _input(event):
	if event.is_action_pressed("pause_menu"):
		toggle_pause()

func toggle_pause():
	ManipuladorPause.pause_all()
	visible = !visible
		
	
func _on_resume_pressed() -> void:
	ManipuladorPause.pause_all()
	visible = false


func _on_back_main_menu_pressed() -> void:
	ManipuladorPause.pause_all()
	SaveData.gold += player.gold
	SaveData.set_and_save()
	get_tree().change_scene_to_file("res://scenes/menu/main_menu.tscn")
