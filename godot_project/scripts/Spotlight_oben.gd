extends RigidBody

export var light_color = Color(1.0, 1.0, 1.0)
export (NodePath) var player

onready var start_transform = global_transform
var place_back_dist = 3
var selection_dist = 3

enum State { FUNCTIONAL, WEARING, BROKEN }

var state = State.FUNCTIONAL

func _ready():
	set_physics_process(true)
	
	$TheSpot/Cylinder/SpotLight.set_color(light_color)

func fall_down():
	if state == State.FUNCTIONAL:
		state = State.BROKEN
		
		$AnimationPlayer.stop_all()
		$TheSpot/Cylinder/SpotLight.light_energy = 0
		mode = RigidBody.MODE_RIGID
		apply_impulse(Vector3(0, 0, 0), Vector3(0, 0.5, 0))

func wear():
	state = State.WEARING
	
	mode = RigidBody.MODE_STATIC

func place_back():
	if state == State.WEARING:
		state = State.FUNCTIONAL
		
		$AnimationPlayer.play("light_movement")
		$TheSpot/Cylinder/SpotLight.light_energy = 4
		global_transform = start_transform

func try_place_back():
	if (get_node(player).global_transform.origin - start_transform.origin).length() < place_back_dist:
		place_back()
		
		return true
	else:
		return false

func _physics_process(delta):
	if state == State.BROKEN:
		if (get_node(player).global_transform.origin - global_transform.origin).length() < selection_dist:
			pass