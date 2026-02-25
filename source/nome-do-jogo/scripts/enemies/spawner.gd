extends Node2D

@onready var player = get_tree().get_first_node_in_group("player")
@export var enemy : PackedScene
@export var destructible : PackedScene

@export var limite_y_min: float = 294
@export var limite_y_max: float = 860

var distance : float = 400

@export var enemy_types : Array[Enemy]

var minute : int = 0
var second : int = 0

var can_spawn : bool = true
var boss_spawned: bool = false

@export var boss_scene: PackedScene
@onready var primeira_fase: Node2D = $".."

func _input(event):
	# Se apertar a tecla "K" (de Kill/Boss), o boss vem na hora
	if event is InputEventKey and event.pressed and event.keycode == KEY_K:
		print("DEBUG: Forçando Boss Fight!")
		iniciar_boss_fight()

func _physics_process(delta: float) -> void:
	if get_tree().get_node_count_in_group("Enemy") < 500:
		can_spawn = true
	else:
		can_spawn = false

func spawn(pos : Vector2, elite : bool = false):
	if can_spawn and !boss_spawned:
		var enemy_instance = enemy.instantiate()
		enemy_instance.type = enemy_types[min(floori(minute/2), enemy_types.size()-1)]
		enemy_instance.position = pos
		enemy_instance.player = player
		enemy_instance.elite = elite
		
		get_tree().current_scene.add_child(enemy_instance)

func get_random_position() -> Vector2:
	
	var random_position = player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))
	random_position.y = clamp(random_position.y,limite_y_min,limite_y_max)
	return random_position

func amount(number : int = 1):
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout():
	second += 5
	
	if second >= 60:
		second = 0
		minute += 1
	
	#Boss aos 15 min
	if minute >= 15 and !boss_spawned:
		iniciar_boss_fight()
	else:
		amount(int(floor((second / 10) + 1)))

func iniciar_boss_fight():
	boss_spawned = true
	if primeira_fase:
		primeira_fase.spawn_boss_arena()
	


func _on_pattern_timeout():
	for i in range(75):
		spawn(get_random_position())
	


func _on_elite_timeout():
	spawn(get_random_position(), true)
	


func _on_destructible_timeout() -> void:
	spawn_destructible(get_random_position())

func spawn_destructible(pos):
	var object_instance = destructible.instantiate()
	object_instance.position = pos
	get_tree().current_scene.add_child(object_instance)
