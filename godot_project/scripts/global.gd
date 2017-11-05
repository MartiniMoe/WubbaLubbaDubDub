extends Node

var spot_an=[true,true,true] #spot informationen welcher spot gerade läuft
var spots = []
var spots_standing = []
var strobo = null
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
	spots_standing.append(get_tree().get_root().get_node("Main/Spotlight_unten"))
	spots_standing.append(get_tree().get_root().get_node("Main/Spotlight_unten2"))
	strobo = get_tree().get_root().get_node("Main/Strobo")
	
	randomize()
	set_process(true)

var time_for_spot_to_fall = randi()%121
var time_elapsed_for_spot_to_fall = 0.0

var time_for_generator_to_fail = randi()%181
var time_elapsed_for_generator_to_fail = 0.0

func _process(delta):
	time+=delta
	time_elapsed_for_spot_to_fall += delta
	if time_elapsed_for_spot_to_fall > time_for_spot_to_fall:
		var spot_to_break = randi()%spots.size()
		spots[spot_to_break].fall_down()
		spot_an[spot_to_break] = false
		time_elapsed_for_spot_to_fall = 0.0
		time_for_spot_to_fall = randi()%121
	
	time_elapsed_for_generator_to_fail += delta
	if time_elapsed_for_generator_to_fail > time_for_generator_to_fail:
		get_tree().get_root().get_node("Main/Generator").break()
		time_elapsed_for_generator_to_fail = 0.0
		time_for_generator_to_fail = randi()%181

func switch_everything_off():
	for spot in spots:
		spot.get_node("TheSpot/Cylinder/SpotLight").light_energy = 0
		spot.get_node("AnimationPlayer").stop_all()
	for spot_standing in spots_standing:
		spot_standing.get_node("Cylinder_001.002/Cylinder_001.001/Cylinder_001/SpotLight").light_energy = 0
		spot_standing.get_node("AnimationPlayer").stop_all()
	strobo.get_node("AnimationPlayer").stop_all()

func switch_everything_on():
	for spot in spots:
		spot.get_node("TheSpot/Cylinder/SpotLight").light_energy = 4
		spot.get_node("AnimationPlayer").play("light_movement")
	for spot_standing in spots_standing:
		spot_standing.get_node("Cylinder_001.002/Cylinder_001.001/Cylinder_001/SpotLight").light_energy = 4
		spot_standing.get_node("AnimationPlayer").play("spot_movement")
	strobo.get_node("AnimationPlayer").play("strobo")