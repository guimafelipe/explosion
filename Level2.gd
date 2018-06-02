extends "res://LevelTemplate.gd"

var exploded_people = 0
const needed_to_win = 3

func _ready():
	level = 2
	$Beyblade.connect("died", self, "lost")
	connect_people()

func connect_people():
	var children = get_children()
	for child in children:
		if child.name.begins_with("Person"):
			child.connect("died", self, "add_exploded_count")

func add_exploded_count():
	exploded_people += 1
#	print("exploded people: " + str(exploded_people))
	if exploded_people == needed_to_win:
#		print("ganhou")
		win()