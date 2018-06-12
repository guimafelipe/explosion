extends "res://LevelTemplate.gd"


func _ready():
	level = 1
	$Alvo.connect("died", self, "win")
	$Beyblade.connect("died", self, "lost")
#	$Timer.connect("timeout", self, "next_level")
	pass

	
	
func next_level():
	get_tree().change_scene("res://Level" + str(level+1) + ".tscn")
