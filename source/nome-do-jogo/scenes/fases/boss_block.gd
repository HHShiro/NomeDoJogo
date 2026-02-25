extends Node2D

@export var boss_scene: PackedScene

@onready var colisao_barreira = $Sprite2D/Barreira/ColisaoBarreira
@onready var spawnpoint = $Sprite2D/Spawnpoint

var fechado = false

func _ready() -> void:
	colisao_barreira.set_deferred("disabled",true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sensor_body_entered(body: Node2D) -> void:
	print("Entrou no sensor")
	if fechado:
		return
	if body.is_in_group("player"):
		fechar_arena()

func fechar_arena():
	fechado = true
	
	colisao_barreira.set_deferred("disabled",false)
	if boss_scene:
		var boss = boss_scene.instantiate()
		boss.position = spawnpoint.global_position
		print("posicionei na",boss.position)
		get_tree().current_scene.call_deferred("add_child",boss)
		boss.died.connect(_on_boss_defeated)
		
func _on_boss_defeated():
	pass
	#get_tree().change_scene_to_file() <- Adicionar cena de vitoria e fim de jogo!
