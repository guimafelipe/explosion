extends KinematicBody

const up_vec = Vector3(0, 1, 0)
const EPS = 0.5

onready var ragdoll = load("res://PersonRagdoll.tscn")
var speed = 400
signal reached_destination
var gravity = -9.8
var velocity = Vector3()
var destination

func _ready():
	pass

func set_destination(new_dest):
	destination = new_dest

func move_to(destination, dt):
	var direction = global_transform.origin - destination
	direction = direction.normalized() * speed * dt
	velocity.x = direction.x
	velocity.z = direction.z

func explode(exp_origin):
	var rag = ragdoll.instance()
	rag.set_as_toplevel(true) #serah que isso eh realmente necessario?
	get_tree().get_root().add_child(rag) # adiciona ele a arvore
	rag.transform.origin = transform.origin #instancia na mesma posicao que o objeto atual
	rag.translation.y = 1.5 #coloca o ragdoll na altura certa
	rag.explode(exp_origin) #chama a explosao
	queue_free()

func _physics_process(delta):
	var direction = Vector3(0, 0, 0)
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	if velocity.y > 0:
		gravity = -20
	else: #truquezinho pra fazer o pulo ficar legal
		gravity = -30
	
	if abs(global_transform.origin - destination) > EPS:
		reached_destination = false
		move_to(destination, delta) #set velocity to move to point
	else:
		reached_destination = true
	
	velocity = move_and_slide(velocity, up_vec)
	
#	var hitCount = get_slide_count()
#
#	if(hitCount > 0):
#		var collision = get_slide_collision(0)
#		if collision.collider is RigidBody:
#			collision.collider.apply_impulse(collision.position, -collision.normal)x