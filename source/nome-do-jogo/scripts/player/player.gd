class_name Player extends CharacterBody2D
@onready var sprite_2d: Sprite2D = $Sprite2D

var isMoving = false
var canRotate = true


var health: float = 100:
	set(value):
		health = max(value,0)
		%Health.value = value
		if health <= 0:
			ManipuladorPause.pause_all()
			
var movement_speed: float = 150.0:
	set(value):
		movement_speed = value
		%MovementSpeed.text = "Movement Speed: " + str(value)
var max_health: float = 100:
	set(value):
		max_health = value
		%Health.value = value
var recovery: float = 0.2
var armor: float = 0
var might: float = 1.0:
	set(value):
		might = value
		%Might.text = "Might: " + str(value)
var area: float = 0:
	set(value):
		area = value
		%Area.text = "Range: " + str(value)
var magnet: float = 0:
	set(value):
		magnet = value
		%Magnet.shape.radius = 50 + value
var growth: float = 1
var luck: float = 1.0


var nearest_enemy
var nearest_enemy_distance: float = 150 + area

var gold: int = 0:
	set(value):
		gold = value
		%Gold.text = "Gold : " + str(value)

var XP : int = 0:
	set(value):
		XP = value
		%XP.value = value
var total_XP : int = 0
var level : int = 1:
	set(value):
		level = value
		%Level.text = "Lv" + str(value)
		%Options.show_option()
		
		if level < 20:
			%XP.max_value = (level * 10) - 5
		elif level >= 20 and level < 40:
			%XP.max_value = (level * 13) - 6
		elif level >= 40:
			%XP.max_value = (level * 16) - 8

func _ready() -> void:
	Persistence.gain_bonus_stats(self)


func _physics_process(delta: float) -> void:
	if is_instance_valid(nearest_enemy):
		pass
	else:
		nearest_enemy_distance = 150 + area
	
	velocity = Input.get_vector("move_left","move_right","move_up","move_down") * movement_speed
	move_and_collide(velocity * delta)
	if velocity.x != 0 or velocity.y != 0:
		if velocity.x != 0:
			sprite_2d.flip_h = velocity.x < 0
		var velocidade_balanco = 15.0
		var angulo_maximo = 5.0
		var tempo = Time.get_ticks_msec() / 1000.0 
		sprite_2d.rotation_degrees = sin(tempo * velocidade_balanco) * angulo_maximo
	else:
		sprite_2d.rotation_degrees = 0.0

	check_XP()
	health += recovery * delta
	


func take_damage(amount):
	health -= max(amount * (amount/(amount+armor)), 1)

func _on_hurtbox_body_entered(body: Node2D) -> void:
	take_damage(body.damage)


func _on_hurt_cooldown_timeout() -> void:
	%HurtboxCollision.set_deferred("disabled", true)
	%HurtboxCollision.set_deferred("disabled", false)

func gain_XP(amount):
	XP += amount * growth
	total_XP += amount * growth

func check_XP():
	if XP > %XP.max_value:
		XP -= %XP.max_value
		level += 1
 

func _on_magnet_area_entered(area):
	if area.has_method("follow"):
		area.follow(self)

func gain_gold(amount):
	gold += amount
	
func open_chest():
	$UI/Chest.open()
