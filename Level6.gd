extends "res://LevelTemplate.gd"

func _ready():
	level = 6
	$Beyblade.connect("died", self, "lost")
	$Alvo.connect("died", self, "win")
