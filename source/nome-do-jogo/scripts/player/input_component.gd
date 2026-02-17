class_name InputComponent extends Node

#Criando variável de direção
var move_direction := Vector2.ZERO

#Função que atualiza a cada tick dentro do jogo
func update() -> void:
	move_direction = Input.get_vector("move_left","move_right","move_up","move_down")
