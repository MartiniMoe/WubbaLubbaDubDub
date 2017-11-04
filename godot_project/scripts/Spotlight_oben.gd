extends RigidBody

export var light_color = Color(1.0, 1.0, 1.0)

onready var start_transform = global_transform
var place_back_dist = 3

func _ready():
	$"Cylinder.001/Cylinder/SpotLight".set_color(light_color)

func fall_down():
	if mode != RigidBody.MODE_RIGID:
		$AnimationPlayer.stop_all()
		mode = RigidBody.MODE_RIGID

func place_back():
	mode = RigidBody.MODE_STATIC
	$AnimationPlayer.play("light_movement")
	global_transform = start_transform

func try_place_back(pos):
	if (pos - start_transform.origin).length() < place_back_dist:
		place_back()