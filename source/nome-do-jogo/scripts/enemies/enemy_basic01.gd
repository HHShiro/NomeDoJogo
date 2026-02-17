extends CharacterBody2D


@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = $HealthComponent
@onready var player = get_tree().get_first_node_in_group("player")
var elite : bool = false:
	set(value):
		elite = value
		if value:
			$Sprite2D.material = load("res://scripts/enemies/rainbow_outline.tres")
			scale = Vector2(1.5,1.5)
var type : Enemy:
	set(value):
		type = value
		$Sprite2D.texture = value.texture

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	movement_component.direction = direction
	movement_component.tick(delta)
	


func _on_hurtbox_component_hurt(damage: Variant) -> void:
	health_component.damage(damage)
	print("Inimigo: ", health_component.current_health)


func _on_health_component_died() -> void:
	queue_free()
