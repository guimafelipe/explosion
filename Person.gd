extends KinematicBody

onready var ragdoll = load("res://PersonRagdoll.tscn")

func _ready():
	pass

func explode(exp_origin):
	var rag = ragdoll.instance()
	rag.set_as_toplevel(true)
	get_tree().get_root().add_child(rag)
	rag.transform.origin = transform.origin
	rag.translation.y = 1.5
	rag.explode(exp_origin)	
	queue_free()