extends "res://LevelTemplate.gd"

func _ready():
	level = 4
	$Beyblade.connect("died", self, "lost")
	$Person.connect("spotted", self, "lost")
	$Person.connect("died", self, "win")
