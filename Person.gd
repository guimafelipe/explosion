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

var speed = 500
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
#	var hitCount = get_slide_count()
#
#	if(hitCount > 0):
#		var collision = get_slide_collision(0)
#		if collision.collider is RigidBody:
#			collision.collider.apply_impulse(collision.position, -collision.normal)x