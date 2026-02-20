extends PanelContainer

@export var item: Weapon:
	set(value):
		item = value
		$TextureRect.texture = value.texture
		$Cooldown.wait_time = value.cooldown
		item.slot = self
		


func _on_cooldown_timeout() -> void:
	if item:
		if item.cooldown > 0:
			$Cooldown.wait_time = item.cooldown
		else:
			$Cooldown.wait_time = 0.1
		item.activate(owner, owner.nearest_enemy, get_tree())
