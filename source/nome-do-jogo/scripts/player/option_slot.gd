extends TextureButton
var upgrade_index: int
@export var weapon : Weapon:
	set(value):
		weapon = value
		
		texture_normal = value.texture
		$Label.text = "Lvl" + str(weapon.level + 1)
		upgrade_index = randi_range(0,value.upgrades.size() - 1)
		$Description.text = value.upgrades[upgrade_index].description


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("click") and weapon:
		print(weapon.title)
		weapon.upgrade_item(upgrade_index)
		get_parent().close_option()
