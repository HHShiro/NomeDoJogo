extends Weapon
class_name SingleShot

func shoot(source,target, scene_tree):
	if target == null or scene_tree.paused == true:
		return
	
	SoundManager.play_sfx(sound)
	var projectile = projectile_node.instantiate()
	
	projectile.position = source.position
	projectile.damage = damage
	projectile.speed = speed
	projectile.source = source
	projectile.direction = (target.position - source.position).normalized()
	projectile.find_child("Sprite2D").texture = texture
	
	scene_tree.current_scene.add_child(projectile)
	
func activate(source, target, scene_tree):
	shoot(source, target, scene_tree)

func upgrade_item(upgrade_index: int):
	if max_level_reached() and passive_item_available:
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[upgrade_index]
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	speed += upgrade.speed
	
	level += 1
