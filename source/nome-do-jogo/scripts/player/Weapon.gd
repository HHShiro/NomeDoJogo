extends Item
class_name Weapon

@export var damage: float
@export var cooldown: float
@export var speed: float

@export var projectile_node : PackedScene = preload("res://scenes/player/projectile.tscn")

@export var upgrades : Array[Upgrade]

@export var item_needed: PassiveItem
@export var evolution: Weapon
@export var sound: AudioStream


var passive_item_available: bool = false:
	set(value):
		passive_item_available = value

var slot

func activate(_source, _target, _scene_tree):
	pass

func is_upgradable() -> bool:
	#Esse é o codigo do video, já que estamos trabalhando
	#Com upgrades infinitos, utilizei outro.
	# if level <= upgrades.size():
		#return true
	# return false
	if upgrades.size() <= 0 or level >= 10:
		return false
	return true

func upgrade_item(upgrade_index: int):
	if not is_upgradable():
		return
	
	var upgrade = upgrades[upgrade_index]
	
	
	damage += upgrade.damage
	cooldown += upgrade.cooldown
	
	level += 1
	
func max_level_reached():
	#Essa função é a do video, como estamos com
	#level up infinito colocarei o nivel maximo como 10
	#if upgrades.size() + 1 == level and upgrades.size() != 0:
		#return true
	#return false
	if level >= 10:
		return true
	return false
