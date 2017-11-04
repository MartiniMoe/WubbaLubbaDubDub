extends Spatial

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var fan=[]

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var fans = load("res://scripts/Crowd_person.gd")
	for i in range(0,8):
		for j in range(0,4):
			fan.append(persons.instance())
			add_child(fan[i*5+j])
			fan[i*5+j].translate((randf()*0.4-0.2)+i*2.4-12.0,0,(randf()*0.4-0.2)+j*2.4-6.0)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
