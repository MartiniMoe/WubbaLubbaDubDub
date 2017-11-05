extends StaticBody

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
export var laune=100.0
var fan=Vector3(0,0,0)
var timer=2
var tomato = preload("res://scenes/tomato.tscn")
var seen=false
var fannumber=-1

func _ready():
	randomize()
	fan=Vector3(randf(),randf(),randf()).normalized() # decides who to focus on how much
	
	set_physics_process(true)
	$"Scene Root/AnimationTreePlayer".set_active(true)
	$Timer.wait_time=4+randf()*2
	$Timer.start()
	$Timer.set_paused(true)


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
		$"Scene Root/AnimationTreePlayer".advance(randf())
	if((laune<20 or (laune<50 and global.playervisible))and !seen):
		$Timer.set_paused(false)
		seen=true
	if(seen and laune >20 and !global.playervisible):
		$Timer.set_paused(true)
		seen=false
	$"Scene Root/AnimationTreePlayer".blend2_node_set_amount("blend2",min(laune-30.0/40.0,1))
	
func mood_reset():
	laune=100.0
	seen=false
	$Timer.set_paused(true)

func _on_Timer_timeout():
	var new_tomato = tomato.instance()
	$Position3D.add_child(new_tomato)
	var vectorto=global.playerpos-$Position3D.global_transform.origin
	vectorto+=Vector3(0,vectorto.length()/3,0)
	new_tomato.apply_impulse($Position3D.global_transform.origin,vectorto)
	new_tomato.crowdperson=fannumber
	pass # replace with function body
