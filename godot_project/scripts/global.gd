extends Node

var spot_an=[true,true,true] #spot informationen welcher spot gerade läuft
var spots = []
var generator_an=true
var points=[]

func _ready():
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben2"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben3"))
	
	randomize()
	set_process(true)

var time_for_spot_to_fall = randi()%121
var time_elapsed_for_spot_to_fall = 0.0

func _process(delta):
	time_elapsed_for_spot_to_fall += delta
	if time_elapsed_for_spot_to_fall > time_for_spot_to_fall:
		var spot_to_break = randi()%spots.size()
		spots[spot_to_break].fall_down()
		spot_an[spot_to_break] = false
		time_elapsed_for_spot_to_fall = 0.0
		time_for_spot_to_fall = randi()%121