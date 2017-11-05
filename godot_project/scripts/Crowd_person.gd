extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var laune=100.0
var fan=Vector3(0,0,0)
var timer=2
var tomato = load("res://scenes/tomato.tscn")
var seen=false

func _ready():
	randomize()
	fan=Vector3(randf(),randf(),randf()).normalized() # decides who to focus on how much
	
	set_physics_process(true)
	$"Scene Root/AnimationTreePlayer".set_active(true)
	$Timer.wait_time=4+randf()*2


func _physics_process(delta):
	if(!global.spot_an[0]||!global.generator_an):
		laune-=delta*fan.x
	if(!global.spot_an[1]||!global.generator_an):
		laune-=delta*fan.y
	if(!global.spot_an[2]||!global.generator_an):
		laune-=delta*fan.z
	if(laune<0):
		laune=0
	if timer>=0:
		timer-=1
	if timer==0:
		print("test")
		$"Scene Root/AnimationTreePlayer".advance(randf())
	if((laune<20 or (laune<50 and global.playervisible))and !seen):
		$Timer.start()
		seen=true
	$"Scene Root/AnimationTreePlayer".blend2_node_set_amount("blend2",min(laune-30.0/40.0,1))
	

func _on_Timer_timeout():
	var new_tomato = tomato.instance()
	$Position3D.add_child(new_tomato)
	var vectorto=global.playerpos-$Position3D.global_transform.origin
	vectorto+=Vector3(0,vectorto.length()/3,0)
	new_tomato.apply_impulse($Position3D.global_transform.origin,vectorto)
	pass # replace with function body
