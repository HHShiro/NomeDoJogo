extends Pickups
class_name Death

func activate():
	super.activate()
	player_reference.get_tree().call_group("Enemy", "take_damage", 9999)
