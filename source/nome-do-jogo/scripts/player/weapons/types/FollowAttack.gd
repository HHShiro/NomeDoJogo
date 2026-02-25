extends Weapon
class_name FollowAttack

var active_companion: CharacterBody2D

@export var amount = 1

func activate(source, _target, scene_tree):
	if not is_instance_valid(active_companion):
		spawn_companion(source, scene_tree)
	else:
		active_companion.player_reference = source

func spawn_companion(source, scene_tree):
	
	active_companion = projectile_node.instantiate()
	
	active_companion.position = source.position + Vector2(30, 30)
	active_companion.player_reference = source
	
	update_companion_stats()
	
	scene_tree.current_scene.call_deferred("add_child", active_companion)

func update_companion_stats():
	if is_instance_valid(active_companion):
		active_companion.update_stats(damage, amount, cooldown, speed)

func upgrade_item(upgrade_index: int):
	if max_level_reached() and passive_item_available:
		slot.item = evolution
		return
	
	if not is_upgradable():
		return
	
	var upgrade = upgrades[upgrade_index]
	
	amount += upgrade.amount      
	damage += upgrade.damage
	cooldown += upgrade.cooldown  
	
	level += 1
	
	update_companion_stats()
