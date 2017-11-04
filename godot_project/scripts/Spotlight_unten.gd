extends StaticBody

export var light_color = Color(1.0, 1.0, 1.0)

func _ready():
	$"Cylinder_001.002/Cylinder_001.001/Cylinder_001/SpotLight".set_color(light_color)