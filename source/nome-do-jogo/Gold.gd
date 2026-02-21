extends Item
class_name Gold

var player_reference: CharacterBody2D
@export var gold: int = 5

func upgrade_item(upgrade_index: int):
	if is_instance_valid(player_reference):
		player_reference.gain_gold(gold)
