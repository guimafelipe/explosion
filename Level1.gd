extends "res://LevelTemplate.gd"

func _ready():
	level = 1
	$Alvo.connect("died", self, "win")
	$Beyblade.connect("died", self, "lost")
	pass

