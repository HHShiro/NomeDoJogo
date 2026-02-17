class_name MovementComponent extends Node 

@export var body: CharacterBody2D
@export var sprite: Sprite2D
@export var speed:= 100.0


var direction:= Vector2.ZERO
func tick(delta: float) -> void:
	if body==null:
		return	
	body.velocity.x = direction.x * speed
	body.velocity.y = direction.y * speed
	body.move_and_slide()
