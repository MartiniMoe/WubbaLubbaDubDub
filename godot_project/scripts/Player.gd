extends KinematicBody

const SPEED = 4
const SELECTION_DIST = 3

enum State {IDLE, WALKING, CLIMBING, FALLING}

func _ready():
	set_physics_process(true)

var falling_speed = 0.0
var state = State.IDLE
var wearing_node = null
func _physics_process(delta):
	var movement = Vector3(0, 0, 0)
	state = State.IDLE
	
	if Input.is_action_just_pressed("ui_select"):
		for node in get_tree().get_nodes_in_group("wearable"):
			if (node.global_transform.origin - global_transform.origin).length() < SELECTION_DIST && \
			   node.state == node.State.BROKEN:
				node.wear()
				wearing_node = node
				break
			
			if node.state == node.State.WEARING:
				var placed_back = node.try_place_back()
				if placed_back:
					wearing_node = null
	
	# MOVEMENT IN XZ
	if Input.is_action_pressed("ui_up"):
		movement += Vector3(0, 0, -1)
		state = State.WALKING
	elif Input.is_action_pressed("ui_down"):
		movement += Vector3(0, 0, 1)
		state = State.WALKING
	if Input.is_action_pressed("ui_left"):
		movement += Vector3(-1, 0, 0)
		state = State.WALKING
	elif Input.is_action_pressed("ui_right"):
		movement += Vector3(1, 0, 0)
		state = State.WALKING
	
	movement = movement.normalized() * SPEED
	
	# ROTATION
	if movement.length() != 0:
		look_at(get_global_transform().origin - movement, Vector3(0, 1, 0))
	
	# CHECK IF NEED TO FALL
	if $RayCastDown.is_colliding():
		falling_speed = 0
	else:
		falling_speed += 0.85
		state = State.FALLING
		movement.y = -falling_speed
	
	# CLIMBING
	for i in range(get_slide_count()):
		var collision = null
		if get_slide_collision(i) != null && get_slide_collision(i).collider != null:
			collision = get_slide_collision(i)
			if collision.collider.is_in_group("climbable") && \
			   collision.normal.angle_to(Vector3(0, 1, 0)) > PI / 4.0 &&  \
			   collision.normal.angle_to(Vector3(0, -1, 0)) > PI / 8.0:
				if abs(movement.dot(collision.normal)) > 0:
					#movement = collision.normal * movement.dot(collision.normal)
					movement.y = SPEED / 2.0
					falling_speed = 0.0
					state = State.CLIMBING
					
					# testing
					for node in get_tree().get_nodes_in_group("wearable"):
						node.fall_down()
	
	# MOVE
	move_and_slide(movement, Vector3(0, 1, 0))
	
	# WEAR
	if wearing_node != null:
		wearing_node.global_transform = global_transform
		wearing_node.global_transform.origin += Vector3(0, 3, 0)
	
	# ANIMATE
	if state == State.IDLE:
		if $PlayerModel/AnimationPlayer.get_current_animation() != "idle" || !$PlayerModel/AnimationPlayer.is_playing():
			$PlayerModel/AnimationPlayer.play("idle")
			$PlayerModel/AnimationPlayer.set_speed_scale(1.0)
	elif state == State.WALKING:
		if $PlayerModel/AnimationPlayer.get_current_animation() != "walk" || !$PlayerModel/AnimationPlayer.is_playing():
			$PlayerModel/AnimationPlayer.play("walk")
			$PlayerModel/AnimationPlayer.set_speed_scale(0.9)
	elif state == State.CLIMBING:
		if $PlayerModel/AnimationPlayer.get_current_animation() != "climb" || !$PlayerModel/AnimationPlayer.is_playing():
			$PlayerModel/AnimationPlayer.play("climb")
			$PlayerModel/AnimationPlayer.set_speed_scale(0.6)