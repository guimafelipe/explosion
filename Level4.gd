extends "res://LevelTemplate.gd"

func _ready():
	$Beyblade.connect("died", self, "lost")
	
