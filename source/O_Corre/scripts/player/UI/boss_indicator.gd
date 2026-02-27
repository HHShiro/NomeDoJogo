extends CanvasLayer

var target_position: Vector2 = Vector2.ZERO
var player_ref: Node2D = null


func setup(target_pos: Vector2, player: Node2D):
	print("fiz o setup")
	target_position = target_pos
	player_ref = player
	show()

func _process(delta):
	if not visible or not is_instance_valid(player_ref):
		print()
		return
		
	var direction_vector = target_position - player_ref.global_position
	var angle = direction_vector.angle()
	
	$ArrowHolder.rotation = angle
	
	if player_ref.global_position.distance_to(target_position) < 200:
		hide()

func stop():
	hide()
	queue_free()
