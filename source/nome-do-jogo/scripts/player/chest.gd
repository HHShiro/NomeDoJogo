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
	get_tree().paused = true
	show()
	$Open.show()
	$Close.hide()


func  _on_open_pressed() -> void:
	chest.play("open_box_animation")
	await chest.animation_finished
	set_reward()
	$Open.hide()
	$Close.show()

func _on_close_pressed() -> void:
	get_tree().paused = false
	hide()
	
func set_reward():
	clear_reward()
	var chance = randf()
	if chance <0.5:
		upgrade_item(2,3)
		print("rare")
	elif chance < 0.75:
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
			rewards.get_child(index).texture = selected_upgrade.texture
			var upgrade_index = randi_range(0,selected_upgrade.upgrades.size() - 1)
			selected_upgrade.upgrade_item(upgrade_index)

func clear_reward():
	for slot in rewards.get_children():
		slot.texture = null


func add_gold(index):
	var gold: Gold = load("res://resources/others/Moeda.tres")
	gold.player_reference = owner
	rewards.get_child(index).texture = gold.texture
	gold.upgrade_item(0)
