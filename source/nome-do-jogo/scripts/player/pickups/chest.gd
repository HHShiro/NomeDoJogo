extends NinePatchRect


@onready var chest: AnimatedSprite2D = $AnimatedSprite2D
@onready var options: VBoxContainer = %Options
@onready var rewards: Control = $Rewards


func _ready():
	randomize()
	hide()
	$Open.show()
	$Close.hide()
	

func open():
	clear_reward()
	chest.play("idle_box_animation")
	$Open.show()
	$Close.hide()
	ManipuladorPause.open_menu(self)

func  _on_open_pressed() -> void:
	SoundManager.play_sfx(load("res://assets/sounds/sfx/chest_pickup_sound.wav"))
	chest.play("open_box_animation")
	await chest.animation_finished
	set_reward()
	$Open.hide()
	$Close.show()

func _on_close_pressed() -> void:
	ManipuladorPause.close_menu(self)
	hide()
	
func set_reward():
	clear_reward()
	var chance = randf()
	var weight = [5.0,2.0,1.0]
	if chance < get_weighted_chance(weight,0):
		upgrade_item(2,3)
		print("rare")
	elif chance < get_weighted_chance(weight,1):
		upgrade_item(1,4)
		print("epic")
	else:
		upgrade_item(0,5)
		print("legendary")

func upgrade_item(start,end):
	for index in range(start,end):
		var upgrades = options.get_available_upgrades()
		
		if upgrades.size() == 0:
			add_gold(index)
		else:
			var selected_upgrade: Item
			selected_upgrade = upgrades.pick_random()
			if selected_upgrade is Weapon and selected_upgrade.max_level_reached() and selected_upgrade.passive_item_available:
				rewards.get_child(index).texture = selected_upgrade.evolution.icon
			else:
				rewards.get_child(index).texture = selected_upgrade.icon
			
			var upgrade_index = randi_range(0,selected_upgrade.upgrades.size() - 1)
			selected_upgrade.upgrade_item(upgrade_index)

func clear_reward():
	for slot in rewards.get_children():
		slot.texture = null


func add_gold(index):
	var gold: Gold = load("res://resources/pickups/gold.tres")
	gold.player_reference = owner
	rewards.get_child(index).texture = gold.icon
	gold.activate()

func get_weighted_chance(weight,index):
	var modified_weight = []
	var sum = 0
	for i in range(weight.size()):
		if i == 0:
			modified_weight.append(weight[i])
			sum += weight[i]
		else:
			modified_weight.append(weight[i] * owner.luck)
			sum += weight[i] * owner.luck
	
	var cumulative = 0
	for i in range(index + 1):
		cumulative += modified_weight[i]
		
	return float(cumulative)/sum
			
