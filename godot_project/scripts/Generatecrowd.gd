extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var fans=[]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var fanscene = load("res://scenes/Crowdperson.tscn")
	for i in range(0,8):
		for j in range(0,4):
			var new_fan = fanscene.instance()
			fans.append(new_fan)
			add_child(new_fan)
			new_fan.translate(Vector3((randf()*1.0-0.5)+i*2.4-12.0,0,(randf()*1.0-0.5)+j*2.4-6.0))
	set_physics_process(true)
func mood_reset():
	for fan in fans:
		fan.mood_reset()

func _physics_process(delta):
	var laune=0
	for fan in fans:
		laune+=fan.laune/fans.size()
	global.mood=laune
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
