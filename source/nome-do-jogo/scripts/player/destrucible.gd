extends Sprite2D

var frame_counter = 0
var separation : float
var health : float = 10:
	set(value):
		health = value
		if health < 0:
			drop_item()
			queue_free()

@onready var player_reference = get_tree().current_scene.find_child("Player")
var drop_node = preload("res://scenes/player/pickups.tscn")
@export var drops : Array[Pickups]

func _physics_process(delta):
	frame_counter += 1 #queria tirar esse negocio de frame,mas deixa para tu ver mlr dps rafa
	if frame_counter >= 6: #tb n botei o negocio de luz(achei desnecesario e n add nenhum code ent ignorei)
		frame_counter = 0
		frame = (frame + 1) % (hframes * vframes)
		
	separation = (player_reference.position - position).length() 
	if separation < player_reference.nearest_enemy_distance:
		player_reference.nearest_enemy = self

func take_damage(amount = 1):
	health -= amount  
	
	var tween = get_tree().create_tween() #lembro que tu ja fez um desse,so n sei onde
	tween.tween_property(self, "modulate", Color(3,0.25, 0.25), 0.2)#botar a cor do felps se quiser rafa
	tween.chain().tween_property(self, "modulate", Color(1, 1, 1), 0.2)
	
	tween.bind_node(self)

func drop_item():
	var item = drops.pick_random()
	
	var item_to_drop = drop_node.instantiate()
	
	item_to_drop.type = item
	item_to_drop.position = position
	item_to_drop.player_reference = player_reference
	
	get_tree().current_scene.call_deferred("add_child", item_to_drop)
