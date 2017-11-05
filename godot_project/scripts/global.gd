extends Node

var spot_an = [ true, true, true] #spot informationen welcher spot gerade läuft
var spots = []
var spots_standing = []
var strobo = null
var instruments = []
var instruments_an = [ true, true, true ]
var musicians = []
var generator_an=true
var points=[]
var playerpos=Vector3(0,0,0)
var playervisible

var mood = 100 # as a percentage value? people get mad, if stuff is broken
               # for a longer period or something?
var health = 100 # repairing all those things costs health and one needs to
                 # collect items or drink water at the (not yet implemented :D)
                 # bar to become fit again?
var time = 0 # the longer the crowd is happy the better, should correlate to the
             # points one gets

# the game should also become more difficult as the game progresses

# Maximum times for things to break in seconds
var max_time_for_one_spot_to_fail = 180
var max_time_for_generator_to_fail = 240
var max_time_for_one_instrument_to_fail = 180

var game_over = false

func _ready():
	randomize()
	
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben2"))
	spots.append(get_tree().get_root().get_node("Main/Spotlight_oben3"))
	spots_standing.append(get_tree().get_root().get_node("Main/Spotlight_unten"))
	spots_standing.append(get_tree().get_root().get_node("Main/Spotlight_unten2"))
	strobo = get_tree().get_root().get_node("Main/Strobo")
	instruments.append(MusicBand.get_node("Drums"))
	musicians.append(get_tree().get_root().get_node("Main/Drummer"))
	instruments.append(MusicBand.get_node("LeadGuitar"))
	musicians.append(get_tree().get_root().get_node("Main/Guitarist"))
	instruments.append(MusicBand.get_node("Singer"))
	musicians.append(get_tree().get_root().get_node("Main/Singer"))
	instruments.append(MusicBand.get_node("Bass"))
	musicians.append(get_tree().get_root().get_node("Main/Bassist"))
	
	set_process(true)

var time_for_one_spot_to_fail = randi()%max_time_for_one_spot_to_fail
var time_elapsed_for_one_spot_to_fail = 0.0
var time_for_generator_to_fail = randi()%max_time_for_generator_to_fail
var time_elapsed_for_generator_to_fail = 0.0
var time_for_one_instrument_to_fail = randi()%max_time_for_one_instrument_to_fail
var time_elapsed_for_one_instrument_to_fail = 0.0

func all_broken():
	for spot in spots:
		spot.fall_down()
	
	get_tree().get_root().get_node("Main/Generator").break()
	
	strobo.hide()

func new_game():
	print("new game")
	
	for spot in spots:
		spot.place_back()
	
	get_tree().get_root().get_node("Main/Generator").repair()
	
	get_tree().get_root().get_node("Main/Crow"d).mood_reset()
	
	strobo.show()
	
	get_tree().get_root().get_node("Main/Overlay/GameOver").hide()
	
	game_over = false

func _process(delta):
	if game_over:
		return
	
	if mood <= 0:
		game_over = true
		
		all_broken()
		get_tree().get_root().get_node("Main/Overlay/GameOver").show()
	
	time+=delta
	time_elapsed_for_one_spot_to_fail += delta
	if time_elapsed_for_one_spot_to_fail > time_for_one_spot_to_fail:
		var spot_to_break = randi()%spots.size()
		spots[spot_to_break].fall_down()
		spot_an[spot_to_break] = false
		time_elapsed_for_one_spot_to_fail = 0.0
		time_for_one_spot_to_fail = randi() % max_time_for_one_spot_to_fail
	
	time_elapsed_for_generator_to_fail += delta
	if time_elapsed_for_generator_to_fail > time_for_generator_to_fail:
		get_tree().get_root().get_node("Main/Generator").break()
		time_elapsed_for_generator_to_fail = 0.0
		time_for_generator_to_fail = randi() % max_time_for_generator_to_fail
	
	time_elapsed_for_one_instrument_to_fail += delta
	if time_elapsed_for_one_instrument_to_fail > time_for_one_instrument_to_fail:
		var instrument_to_fail = randi() % instruments.size()
		instruments[instrument_to_fail].set_volume_db(-80)
		musicians[instrument_to_fail].set_broken(true)
		time_elapsed_for_one_instrument_to_fail = 0.0
		time_for_one_instrument_to_fail = randi() % max_time_for_one_instrument_to_fail
	
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
		if spot.state == spot.State.FUNCTIONAL:
			spot.get_node("TheSpot/Cylinder/SpotLight").light_energy = 4
			spot.get_node("AnimationPlayer").play("light_movement")
	for spot_standing in spots_standing:
		spot_standing.get_node("Cylinder_001.002/Cylinder_001.001/Cylinder_001/SpotLight").light_energy = 4
		spot_standing.get_node("AnimationPlayer").play("spot_movement")
	strobo.get_node("AnimationPlayer").play("strobo")
