extends Node2D

@export var boss_scene: PackedScene

@onready var colisao_barreira = $Sprite2D/Barreira/ColisaoBarreira
@onready var spawnpoint = $Sprite2D/Spawnpoint
@onready var indicator_scene = preload("res://scenes/player/boss_indicator.tscn")
var indicador_atual = null

var fechado = false

func _ready() -> void:
	colisao_barreira.set_deferred("disabled",true)
	create_indicator()

func create_indicator():

	var player = get_tree().get_first_node_in_group("player")
	
	if player and indicator_scene:
		indicador_atual = indicator_scene.instantiate()
		get_tree().current_scene.call_deferred("add_child", indicador_atual)
		indicador_atual.setup(spawnpoint.global_position, player)
		


func _on_sensor_body_entered(body: Node2D) -> void:
	print("Entrou no sensor")
	if fechado:
		return
	if body.is_in_group("player"):
		fechar_arena(body)
		if is_instance_valid(indicador_atual):
			indicador_atual.queue_free()
			indicador_atual = null
			
func fechar_arena(player):
	fechado = true
	
	colisao_barreira.set_deferred("disabled",false)
	
	if boss_scene:
		var boss = boss_scene.instantiate()
		boss.global_position = spawnpoint.global_position
		print("posicionei na",boss.global_position)
		get_tree().current_scene.call_deferred("add_child",boss)
		boss.died.connect(_on_boss_defeated)
		
func _on_boss_defeated():
	print("Boss derrotado!")
	get_tree().change_scene_to_file("res://scenes/fases/end_scene_test.tscn") # <- Adicionar cena de vitoria e fim de jogo!
