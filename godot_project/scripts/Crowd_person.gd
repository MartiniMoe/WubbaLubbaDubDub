extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var laune=100.0
var fan=Vector3(0,0,0)

func _ready():
	randomize()
	Vector3(randf(),randf(),randf()).normalized() # decides who to focus on how much
	# Called every time the node is added to the scene.
	# Initialization here
	set_physics_process(true)
	var rnd = randf()
	print(str(rnd))
	$"Scene Root/AnimationTreePlayer".set_active(true)
	$"Scene Root/AnimationPlayer".set_speed_scale(rnd*10)
	$"Scene Root/AnimationTreePlayer".timeseek_node_seek("seek", rnd*2)
	pass

func _physics_process(delta):
	if(!global.spot_an[0]):
		laune-=delta*fan.x
	if(!global.spot_an[1]):
		laune-=delta*fan.y
	if(!global.spot_an[2]):
		laune-=delta*fan.z
	if(laune<0):
		laune=0
	$"Scene Root/AnimationTreePlayer".blend2_node_set_amount("blend2",min(laune-30.0/40.0,1))
	