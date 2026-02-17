extends Node2D

@export var player : CharacterBody2D
@export var enemy : PackedScene


var distance : float = 400
var minute : int = 0
var second : int = 0

func spawn(pos : Vector2):
	var enemy_instance = enemy.instantiate()
	enemy_instance.position = pos
	enemy_instance.player = player
	add_child(enemy_instance)

func get_random_position() -> Vector2:
	return player.position + distance * Vector2.RIGHT.rotated(randf_range(0, 2 * PI))

func amount(number : int = 1):
	print(number)
	for i in range(number):
		spawn(get_random_position())

func _on_timer_timeout():
	second += 5
	
	if second >= 60:
		second = 0
		minute += 1
	amount(int(floor((second / 10) + 1)))
