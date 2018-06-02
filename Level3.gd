extends "res://LevelTemplate.gd"

func _ready():
	level = 3
	$Beyblade.connect("died", self, "lost")
	$Car.connect("died", self, "win")
