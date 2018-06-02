extends Spatial

const level = 1

func _ready():
	$Alvo.connect("died", self, "win")
	pass

func win():
	print("Venceu level 1")
	get_tree().change_scene("res://Level2.tscn")