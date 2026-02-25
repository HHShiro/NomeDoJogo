extends CharacterBody2D
class_name PretomeloCompanion

enum State { IDLE, ATACANDO, RETORNANDO, COOLDOWN }

var current_state = State.IDLE
var player_reference: Node2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

var speed= 150.0
var damage = 10.0
var amount = 3  
var cooldown = 2.0  

var attacks_left = 0
var current_target: Node2D
var cooldown_timer = 0.0

func _ready():
	attacks_left = amount
	animated_sprite.play("moving")
	animated_sprite.scale = Vector2(1.5,1.5)
	current_state = State.IDLE

func _physics_process(delta):
	if velocity.x != 0:
		animated_sprite.flip_h = velocity.x < 0
	
	match current_state:
		State.IDLE:
			handle_idle(delta)
		State.ATACANDO:
			handle_attack(delta)
		State.RETORNANDO:
			handle_return(delta)
		State.COOLDOWN:
			handle_cooldown(delta)

# --- Estados ---

func handle_idle(delta):
	if not is_instance_valid(player_reference): return
	
	var distance = global_position.distance_to(player_reference.global_position)
	if distance > 60:
		velocity = position.direction_to(player_reference.position) * speed
		move_and_slide()
	
	if attacks_left > 0:
		var enemy = find_nearest_enemy()
		if enemy != null:
			if enemy.is_in_group("Enemy"):
				current_target = enemy
			else:
				current_target = enemy.get_parent()
		current_state = State.ATACANDO

func handle_attack(delta):
	if not is_instance_valid(current_target):
		current_state = State.IDLE
		return
	
	velocity = position.direction_to(current_target.position) * (speed * 1.5) # Corre mais rápido pra atacar
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		var collider = collision.get_collider()
		if collider.is_in_group("Enemy"):
			bite(collider)
		if collider.is_in_group("Destructible"):
			bite(collider.get_parent(),true)

func handle_return(delta):
	if not is_instance_valid(player_reference): return
	
	var distance = global_position.distance_to(player_reference.global_position)
	velocity = position.direction_to(player_reference.position) * speed
	move_and_slide()
	collision_shape_2d.disabled = true
	
	if distance < 40:
		current_state = State.COOLDOWN
		cooldown_timer = cooldown
		

func handle_cooldown(delta):

	if is_instance_valid(player_reference):
		if global_position.distance_to(player_reference.global_position) > 50:
			velocity = position.direction_to(player_reference.position) * (speed * 0.8) #Descansa Devagar
			move_and_slide()
	
	cooldown_timer -= delta
	if cooldown_timer <= 0:

		attacks_left = amount
		current_state = State.IDLE
		collision_shape_2d.disabled = false
		# Incluir som de latido aqui


func bite(enemy,destructible: bool = false):
	var direction = (enemy.global_position - global_position).normalized()
	if enemy.has_method("take_damage"):
		if "might" in player_reference:
			enemy.take_damage(damage * player_reference.might)
		else:
			enemy.take_damage(damage)
		
		if(!destructible):	
			enemy.knockback += direction * 75

	
	# Tocar som de cachorro bravo aqui!
	
	attacks_left -= 1
	
	position -= velocity.normalized() * 20
	
	if attacks_left <= 0:
		current_target = null
		current_state = State.RETORNANDO
	else:
	
		if not is_instance_valid(enemy) or enemy.health <= 0:
			current_target = null
			current_state = State.IDLE
		

func find_nearest_enemy():
	var enemies = get_tree().get_nodes_in_group("Enemy")
	enemies.append_array(get_tree().get_nodes_in_group("Destructible"))
	if enemies.is_empty():
		return null
	
	var nearest = null
	var min_dist = INF
	
	for enemy in enemies:
		var dist
		if enemy.is_in_group("Enemy"):
			dist = global_position.distance_to(enemy.global_position)
		else:
			dist = global_position.distance_to(enemy.get_parent().global_position)
		if dist < min_dist and dist < 500:
			min_dist = dist
			nearest = enemy
	return nearest


func update_stats(new_damage, new_amount, new_cooldown, new_speed):
	damage = new_damage
	if new_amount > amount:
		attacks_left += (new_amount - amount)
	amount = new_amount
	cooldown = new_cooldown
	speed = new_speed
