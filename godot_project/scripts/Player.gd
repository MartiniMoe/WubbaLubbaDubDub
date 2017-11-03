extends KinematicBody

const SPEED = 200

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	var movement = Vector3()
	
	if Input.is_action_pressed("ui_up"):
		movement += Vector3(0, 0, -1)
	elif Input.is_action_pressed("ui_down"):
		movement += Vector3(0, 0, 1)
	
	if Input.is_action_pressed("ui_left"):
		movement += Vector3(-1, 0, 0)
	elif Input.is_action_pressed("ui_right"):
		movement += Vector3(1, 0, 0)
	
	movement = movement.normalized() * delta * SPEED
	
	move_and_slide(movement)