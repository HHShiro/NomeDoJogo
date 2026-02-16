class_name Player extends CharacterBody2D

@onready var input_component: InputComponent = $InputComponent


func _physics_process(delta: float) -> void:
	
	#Ler os Controles
	input_component.update()
