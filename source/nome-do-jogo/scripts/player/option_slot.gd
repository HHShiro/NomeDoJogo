extends TextureButton
var upgrade_index: int
var passive_item_available:= false:
	set(value):
		passive_item_available = value
@export var item : Item:
	set(value):
		item = value
		if value.is_class("Weapon"):
			value.passive_item_available = passive_item_available
		if value.upgrades.size() > 0 and (value.level < 10 or (not passive_item_available)): #<- 10 é o nivel maximo!!
			texture_normal = value.texture
			$Label.text = "Lvl" + str(item.level + 1)
			upgrade_index = randi_range(0,value.upgrades.size() - 1)
			$Description.text = value.upgrades[upgrade_index].description
		else:
			texture_normal = value.evolution.texture
			$Label.text = ""
			$Description.text = "EVOLUTION"


func _on_gui_input(event: InputEvent):
	if event.is_action_pressed("click") and item:
		print(item.title)
		item.upgrade_item(upgrade_index)
		get_parent().close_option()
