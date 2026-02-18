extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var enemy : PackedScene

var distance : float = 400

@export var enemy_types : Array[Enemy]

var minute : int = 0
var second : int = 0

var can_spawn : bool = true

func _physics_process(delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < 500:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos : Vector2, elite : bool = false):
	var enemy_instance = enemy.instantiate()
	enemy_instance.type = enemy_types[min(minute, enemy_types.size()-1)]
	enemy_instance.position = pos
	enemy_instance.player = player
	enemy_instance.elite = elite
	
	get_tree().current_scene.add_child(enemy_instance)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout():
	second += 5
	
	if second >= 60:
		second = 0
		minute += 1
	amount(int(floor((second / 10) + 1)))


func _on_pattern_timeout():
	for i in range(75):
		spawn(get_random_position())
	


func _on_elite_timeout():
	spawn(get_random_position(), true)
	
