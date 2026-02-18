class_name Player extends CharacterBody2D

var speed: float = 150
var health: float = 100:
	set(value):
		health = value
		%Health.value = value
		
var nearest_enemy : CharacterBody2D
var nearest_enemy_distance: float = INF

signal died

func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		pass
	else:
		nearest_enemy_distance = INF
	
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * speed
	move_and_collide(velocity * delta)

func take_damage(amount):
	health -= amount
	if health <= 0:
		emit_signal("died")

func _on_hurtbox_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_hurt_cooldown_timeout() -> void:
	%HurtboxCollision.set_deferred("disabled", true)
	%HurtboxCollision.set_deferred("disabled", false)
