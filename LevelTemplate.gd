extends Spatial

var level = 1
var won = false


func win():
	won = true
	$TestMap/TimerWon.start()
#	get_tree().change_scene("res://Level" + str(level+1) + ".tscn")
	

func lost():
	if won:
		return
	$TestMap/TimerLost.start()
#	get_tree().change_scene("res://Level" + str(level) + ".tscn")
	
func _ready():
	$TestMap/TimerWon.connect("timeout", self, "call_next_level")
	$TestMap/TimerLost.connect("timeout", self, "call_same_level")
	
func call_next_level():
	if level < 6:
		get_tree().change_scene("res://Level" + str(level+1) + ".tscn")
	else:
		get_tree().change_scene("res://Menu.tscn")
	
	
func call_same_level():
	get_tree().change_scene("res://Level" + str(level) + ".tscn")
	
func _physics_process(delta):
	if Input.is_action_just_pressed("reload"):
		call_same_level()