extends StaticBody

export var light_color = Color(1.0, 1.0, 1.0)

func _ready():
	$"Cylinder.001/Cylinder/SpotLight".set_color(light_color)