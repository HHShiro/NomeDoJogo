extends Control

func _ready() -> void:
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

func _on_back_pressed() -> void:
	menu()

func tween_pop(panel):
	SoundManager.play_sfx(load("res://assets/sfx/button_menu_sound.wav"))
	panel.scale = Vector2(0.85,0.85)
	var tween = get_tree().create_tween().set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_ELASTIC)
	await tween.tween_property(panel, "scale", Vector2(1,1), 0.5)
