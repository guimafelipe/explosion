extends "res://Person.gd"

func _ready():
	set_route()
	ragdoll = load("res://CarRagdoll.tscn")
	speed = 1200