extends Control

var acchievements=[false, false, false, false]
var hue=0.6
var speed=0.3
var viewportsize=Vector2(1080,600)

func _ready():

	#if get_viewport().size != viewportsize:
	#	viewportsize=get_viewport().size
	#	$Stimmung.rect_position=Vector2(viewportsize.x-324,40)
	#	$Sprite.position=Vector2(62,viewportsize.y-62)
	#	$Sprite.position=Vector2(100,viewportsize.y-62)
	#	$Sprite.position=Vector2(138,viewportsize.y-62)
	#	$Label.rect_position=Vector2(viewportsize.x-62,viewportsize.y-59)
	set_process(true)

func from_hue(hue,sat):
	var color=Color(0,0,0);
	if(sat>0):
		if(hue<1.0/6.0):
			color=Color(1,hue*6.0*sat+1-sat,1-sat)
		elif(hue<2.0/6.0):
			color=Color((2.0-hue*6.0)*sat+1-sat,1,1-sat)
		elif(hue<3.0/6.0):
			color=Color(1-sat,1,(hue*6.0-2)*sat+1-sat)
		elif(hue<4.0/6.0):
			color=Color(1-sat,(4.0-hue*6.0)*sat+1-sat,1)
		elif(hue<5.0/6.0):
			color=Color((hue*6.0-4.0)*sat+1-sat,1-sat,1)
		else:
			color=Color(1,1-sat,(6.0-hue*6.0)*sat+1-sat)
	return color

func _process(delta):
	
	$Healthbar.value=global.health
	$Stimmung.value=global.mood
	speed=global.mood/100.0
	hue+=delta*speed
	$Label.text=str(ceil(global.time*10)/10)
	$Label.rect_position=Vector2(962+randf()*4-2,541+randf()*4-2)
	if(hue>1):
		hue -= 1
	var sat=global.mood/100.0
	$Stimmung.self_modulate=from_hue(hue,sat)
	if global.spot_an[0] and global.generator_an:
		$Sprite.region_rect=Rect2(64,0,64,64)
	else:
		$Sprite.region_rect=Rect2(0,0,64,64)
	if global.spot_an[1] and global.generator_an:
		$Sprite2.region_rect=Rect2(64,0,64,64)
	else:
		$Sprite2.region_rect=Rect2(0,0,64,64)
	if global.spot_an[2] and global.generator_an:
		$Sprite3.region_rect=Rect2(64,0,64,64)
	else:
		$Sprite3.region_rect=Rect2(0,0,64,64)

func _on_Button_pressed():
	print("pressed new game")
	global.new_game()
