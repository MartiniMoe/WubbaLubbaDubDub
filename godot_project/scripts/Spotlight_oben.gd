extends RigidBody

export var light_color = Color(1.0, 1.0, 1.0)
export var index = 0

var place_back_dist = 3
var selection_dist = 3

enum State { FUNCTIONAL, WEARING, BROKEN }

var player
var start_transform

var state = State.FUNCTIONAL

var material = null
func _ready():
	set_physics_process(true)
	
	$TheSpot/Cylinder/SpotLight.set_color(light_color)
	
	player = $"../Player".get_path()
	start_transform = global_transform

func fall_down():
	if state == State.FUNCTIONAL:
		state = State.BROKEN
		
		$AnimationPlayer.stop_all()
		$TheSpot/Cylinder/SpotLight.light_energy = 0
		mode = RigidBody.MODE_RIGID
		apply_impulse(Vector3(0, 0, 0), Vector3(0, -0.5, 0))

func wear():
	state = State.WEARING
	
	mode = RigidBody.MODE_STATIC

func place_back():
	if state == State.WEARING:
		state = State.FUNCTIONAL
		
		set_global_transform(start_transform)
		if global.generator_an:
			$AnimationPlayer.play("light_movement")
			$TheSpot/Cylinder/SpotLight.light_energy = 4
		global.spot_an[index] = true

func try_place_back():
	if (get_node(player).global_transform.origin - start_transform.origin).length() < place_back_dist:
		place_back()
		
		return true
	else:
		return false

func _physics_process(delta):
	if state == State.BROKEN && (get_node(player).global_transform.origin - global_transform.origin).length() < selection_dist:
		$Hilight_sphere.show()
	else:
		$Hilight_sphere.hide()