class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = $InputComponent
@onready var movement_component: MovementComponent = $MovementComponent
@onready var health_component: HealthComponent = $HealthComponent


func _physics_process(delta: float) -> void:
	
	#Ler os Controles
	input_component.update()
	movement_component.direction = input_component.move_direction
	movement_component.tick(delta)


func _on_hurtbox_component_hurt(damage: Variant) -> void:
	health_component.damage(damage)
	print(health_component.current_health)
