extends Node

var spot_an=[true,true,true] #spot informationen welcher spot gerade läuft
var spots = []
var generator_an=true
var points=[]

var mood = 100 # as a percentage value? people get mad, if stuff is broken
               # for a longer period or something?
var health = 100 # repairing all those things costs health and one needs to
                 # collect items or drink water at the (not yet implemented :D)
                 # bar to become fit again?
var time = 0 # the longer the crowd is happy the better, should correlate to the
             # points one gets

# the game should also become more difficult as the game progresses

func _ready():
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben2"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben3"))
	
	randomize()
	set_process(true)

var time_for_spot_to_fall = randi()%121
var time_elapsed_for_spot_to_fall = 0.0

func _process(delta):
	time+=delta
	time_elapsed_for_spot_to_fall += delta
	if time_elapsed_for_spot_to_fall > time_for_spot_to_fall:
		var spot_to_break = randi()%spots.size()
		spots[spot_to_break].fall_down()
		spot_an[spot_to_break] = false
		time_elapsed_for_spot_to_fall = 0.0
		time_for_spot_to_fall = randi()%121
