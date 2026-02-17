class_name HealthComponent extends Node

@export var max_health:= 100.0
@export var current_health: float

signal health_changed
signal died

func _ready():
	current_health = max_health

func damage(damage: float):
	current_health -= damage
	emit_signal("health_changed")
	if current_health <= 0:
		emit_signal("died")
	
func heal(heal: float):
	damage(-heal)
	
