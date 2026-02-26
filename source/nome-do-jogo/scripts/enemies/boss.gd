extends CharacterBody2D

signal died

var damage_popup_node = preload("res://scenes/player/damage.tscn")


@export var max_health = 5000
@export var speed = 100
@export var damage: float
@export var dash_speed = 600
@export var friccao = 1
@export var tempo_esperando = 1.0
@export var duracao_dash = 0.4
@export var janela_espera = 1.0

var is_dashing = false
var is_preparing = false
var is_resting = false

var separation: float
var knockback: Vector2

var health: float:
	set(value):
		health = value
		if health <= 0:
			died.emit()
			queue_free()
			

@onready var player = get_tree().get_first_node_in_group("player")
@onready var sprite = $Sprite2D

func take_damage(amount):
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "modulate", Color(0.996, 0.22, 0.404, 1.0), 0.2)
	tween.chain().tween_property($Sprite2D, "modulate", Color(1,1,1), 0.2)
	tween.bind_node(self)
	
	var chance = randf()
	var modifier: float = 2.0 if (chance < (1.0 - (1.0/player.luck))) else 1.0
	
	damage_popup(amount,modifier)
	health -= amount * modifier
	$ProgressBar.value = health
	
func _ready():
	health = max_health
	$ProgressBar.max_value = max_health
	$ProgressBar.value = max_health
	start_attack_pattern()
func _physics_process(delta):
	check_separation(delta)
	knockback = knockback.move_toward(Vector2.ZERO,1)
	if not is_instance_valid(player):
		return
	
	if is_dashing:
		velocity = velocity.lerp(Vector2.ZERO, friccao * delta)
		move_and_slide()
		
	elif is_preparing or is_resting:
		velocity = Vector2.ZERO
		move_and_slide()
		
		
	else:
		var direction = (player.position - position).normalized()
		velocity = direction * speed
		if sprite:
			sprite.flip_h = direction.x < 0
		move_and_slide()


func check_separation(_delta):
	separation = (player.position - position).length()
		
	if separation < player.nearest_enemy_distance:
		player.nearest_enemy_distance = separation
		player.nearest_enemy = null
		player.nearest_enemy = self

func damage_popup(amount, modifier = 1.0):
	var popup = damage_popup_node.instantiate()
	popup.text = str(amount * modifier)
	popup.position = position + Vector2(-50,-25)
	if modifier > 1.0:
		popup.set("theme_override_colors/font_color",Color.DARK_GOLDENROD)
		popup.text += "!"
	get_tree().current_scene.add_child(popup)

func start_attack_pattern():
	while true:
		await get_tree().create_timer(randf_range(3.0,5.0)).timeout
		
		if not is_instance_valid(player):
			break
		
		is_preparing = true
		
		var tween = create_tween()
		tween.tween_property(sprite, "modulate", Color(1.915, 0.009, 0.0, 1.0), 0.5)
		
		await get_tree().create_timer(tempo_esperando).timeout
		
		is_preparing = false
		is_dashing = true
		
		$RastroTimer.start()
		var direction = global_position.direction_to(player.global_position)
		velocity = direction * dash_speed
		
		#Colocar som do dash
		
		await get_tree().create_timer(duracao_dash).timeout
		
		is_dashing = false
		is_resting = true
		
		$RastroTimer.stop()
		var tween_back = create_tween()
		tween_back.tween_property(sprite, "modulate", Color.WHITE, 0.2)
		
		velocity = Vector2.ZERO
		await get_tree().create_timer(janela_espera).timeout	
		
		is_resting = false


func _on_rastro_timer_timeout() -> void:
	var rastro = sprite.duplicate()
	rastro.global_position = global_position
	rastro.modulate.a = 0.5
	rastro.z_index = -1
	get_parent().add_child(rastro)
	
	var tween = create_tween()
	tween.tween_property(rastro, "modulate:a", 0.0, 0.5)
	tween.tween_callback(rastro.queue_free)
