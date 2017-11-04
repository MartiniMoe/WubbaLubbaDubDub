extends OmniLight

func _ready():
	set_process(true)

var strobo_on = false
var time_elapsed = 0.0
func _process(delta):
	time_elapsed += delta
	
	if strobo_on && time_elapsed > 1:
		$AnimationPlayer.stop(true)
		time_elapsed = 0
		strobo_on = false
	
	if !strobo_on && time_elapsed > 10:
		$AnimationPlayer.play("strobo")
		time_elapsed = 0
		strobo_on = true