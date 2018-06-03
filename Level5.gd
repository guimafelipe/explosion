extends "res://LevelTemplate.gd"

var bombs_exploded = 0
var total_bombs = 0

var check_bombs = false
var check_person = false


func _ready():
	level = 5
	var children = get_children()
	for child in children:
		if child.name.begins_with("Bomba"):
			total_bombs += 1
			child.connect("exploded", self, "add_bomb_exploded")
	$Person.connect("died", self, "killed_person")
	$Beyblade.connect("died", self, "check_lose")

func check_lose():
	var timer = get_tree().create_timer(3.0)
	timer.connect("timeout", self, "lost")

func killed_person():
	if check_bombs:
		win()
	check_person = true

func finished_bombs():
	if check_person:
		win()
	check_bombs = true

func add_bomb_exploded():
	bombs_exploded += 1
	if bombs_exploded == total_bombs:
		finished_bombs()