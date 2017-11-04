extends Node

var spot_an = [true, true, true] #spot informationen welcher spot gerade läuft
var generator_an = true
var points = []

var mood = 100 # as a percentage value? people get mad, if stuff is broken
               # for a longer period or something?
var health = 100 # repairing all those things costs health and one needs to
                 # collect items or drink water at the (not yet implemented :D)
                 # bar to become fit again?
var time = 0 # the longer the crowd is happy the better, should correlate to the
             # points one gets

# the game should also become more difficult as the game progresses

func _ready():
	pass
