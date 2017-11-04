extends KinematicBody

const SPEED = 10

func _ready():
	set_physics_process(true)

var falling_speed = 0.0
func _physics_process(delta):
	var movement = Vector3(0, 0, 0)
	
	if Input.is_action_pressed("ui_up"):
		movement += Vector3(0, 0, -1)
	elif Input.is_action_pressed("ui_down"):
		movement += Vector3(0, 0, 1)
	
	if Input.is_action_pressed("ui_left"):
		movement += Vector3(-1, 0, 0)
	elif Input.is_action_pressed("ui_right"):
		movement += Vector3(1, 0, 0)
	
	movement = movement.normalized() * SPEED
	
	if is_on_floor():
		falling_speed = 0
	else:
		falling_speed += 0.2
	
	movement.y = -falling_speed
	
	for i in range(get_slide_count()):
		var collision = null
		if get_slide_collision(i) != null && get_slide_collision(i).collider != null:
			collision = get_slide_collision(i)
			if collision.collider.is_in_group("climbable") && collision.normal.angle_to(Vector3(0, 1, 0)) > PI/4.0:
				movement.y = SPEED
				falling_speed = 0.0
	
	move_and_slide(movement, Vector3(0, 1, 0))