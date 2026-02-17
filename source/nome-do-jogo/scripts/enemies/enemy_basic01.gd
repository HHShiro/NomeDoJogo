extends CharacterBody2D

var player_reference : CharacterBody2D

@onready var movement_component: MovementComponent = $MovementComponent

@onready var player = get_tree().get_first_node_in_group("player")
func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	movement_component.direction = direction
	movement_component.tick(delta)
	
