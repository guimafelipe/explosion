extends Spatial

var level = 1
var won = false

func win():
	won = true
	get_tree().change_scene("res://Level" + str(level+1) + ".tscn")

func lost():
	if won:
		return
	get_tree().change_scene("res://Level" + str(level) + ".tscn")