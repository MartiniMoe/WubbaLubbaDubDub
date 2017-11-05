extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var laune=100.0
var fan=Vector3(0,0,0)
var timer=2

func _ready():
	randomize()
	fan=Vector3(randf(),randf(),randf()).normalized() # decides who to focus on how much
	
	set_physics_process(true)
	$"Scene Root/AnimationTreePlayer".set_active(true)


func _physics_process(delta):
	if(!global.spot_an[0]):
		laune-=delta*fan.x
	if(!global.spot_an[1]):
		laune-=delta*fan.y
	if(!global.spot_an[2]):
		laune-=delta*fan.z
	if(laune<0):
		laune=0
	if timer>=0:
		timer-=1
	if timer==0:
		print("test")
		$"Scene Root/AnimationTreePlayer".advance(randf())
	$"Scene Root/AnimationTreePlayer".blend2_node_set_amount("blend2",min(laune-30.0/40.0,1))
	