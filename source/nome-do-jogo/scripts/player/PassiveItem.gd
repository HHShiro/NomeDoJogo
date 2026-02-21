extends Item
class_name PassiveItem

@export var upgrades : Array[Stats]
var player_reference

func is_upgradable() -> bool:
	#Esse é o codigo do video, já que estamos trabalhando
	#Com upgrades infinitos, utilizei outro.
	# if level <= upgrades.size():
		#return true
	# return false
	if upgrades.size() <= 0 or level > 10:
		return false
	return true
	
func upgrade_item(upgrade_index: int):
	if not is_upgradable():
		return
		
	if player_reference == null:
		return
	
	var upgrade = upgrades[upgrade_index]
	
	player_reference.max_health += upgrade.max_health
	player_reference.recovery += upgrade.recovery
	player_reference.armor += upgrade.armor
	player_reference.movement_speed += upgrade.movement_speed
	player_reference.might += upgrade.might
	player_reference.area += upgrade.area
	player_reference.magnet += upgrade.magnet
	player_reference.growth += upgrade.growth
	
	level += 1
