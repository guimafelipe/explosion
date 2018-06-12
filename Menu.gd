extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func call_start_game():
	get_tree().change_scene("res://Level1.tscn")
	
func quit_game():
	get_tree().quit()

func _on_Play_pressed():
	call_start_game()


func _on_Quit_pressed():
	quit_game()
