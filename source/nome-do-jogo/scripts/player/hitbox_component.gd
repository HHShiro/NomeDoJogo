class_name HitboxComponent extends Area2D

@export var damage:= 1
@onready var collision = $CollisionShape2D
@onready var disable_timer = $DisableTimer

func tempdisable():
	collision.call_deferred("set","disabled",true)
	disable_timer.start()



func _on_disable_timer_timeout() -> void:
	collision.call_deferred("set","disabled",false)
