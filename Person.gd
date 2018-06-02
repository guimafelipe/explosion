extends KinematicBody

export var loop = false #to continue in the route
export var exploderous = false #if explode player in contact

const up_vec = Vector3(0, 1, 0)
const EPS = 0.5

var ragdoll
var speed = 400

signal reached_destination
signal died

var gravity = -9.8
var velocity = Vector3()
var destination

var route_pos = []
var initial_point = -1

func set_route():
	if $Route:
		for point in $Route.get_children():
			route_pos.append(point.global_transform.origin)
		set_destination(route_pos[0])
		initial_point = 0
	ragdoll = load("res://PersonRagdoll.tscn")

func _ready():
	set_route()

func set_destination(new_dest):
	destination = new_dest

func move_to(destination, dt):
	var direction = destination - global_transform.origin
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
	emit_signal("died")
	queue_free()

func change_destination():
	initial_point+=1
	if initial_point < route_pos.size():
		set_destination(route_pos[initial_point])
	elif loop:
		initial_point = 0
#		print("resetou posicao")
		set_destination(route_pos[initial_point])
	else:
#		print("finalizou rota")
		initial_point = -1 #chegou ao ultimo ponto

func _physics_process(delta):
	var direction = Vector3(0, 0, 0)
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	if velocity.y > 0:
		gravity = -20
	else: #truquezinho pra fazer o pulo ficar legal
		gravity = -30
	
	if initial_point != -1:
		var here = self.global_transform.origin
		if here.distance_to(destination) > EPS:
#			reached_destination = false
			move_to(destination, delta) #set velocity to move to point
		else:
#			reached_destination = true
			change_destination()
	
	velocity = move_and_slide(velocity, up_vec)
#
#	var hitCount = get_slide_count()
#
#	if(hitCount > 0):
#		var collision = get_slide_collision(0)
#		if collision.collider is RigidBody:
#			collision.collider.apply_impulse(collision.position, -collision.normal)