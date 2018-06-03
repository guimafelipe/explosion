extends KinematicBody

export var loop = false #to continue in the route
export var exploderous = false #if explode player in contact
export var has_vision = false
#export var vision_size = 4 #vision range

const up_vec = Vector3(0, 1, 0)
const EPS = 0.5

var ragdoll
var speed = 400

signal reached_destination #emitted when reached destination
signal died #emitted when died
signal spotted #emmited when see beyblade

var gravity = -9.8
var velocity = Vector3()
var destination
#var need_facing_adjust = true

var route_pos = []
var initial_point = -1

func set_route():
	if $Route:
		for point in $Route.get_children():
			route_pos.append(point.global_transform.origin)
		set_destination(route_pos[0])
		initial_point = 0
	ragdoll = load("res://PersonRagdoll.tscn")

func adjust_facing(where_to_look, up):
	var here = global_transform.origin
	var look_dir = where_to_look
	look_dir.y = here.y #isso resolve um bug bizarro e impede rotação no eixo x no look_at
	if look_dir.distance_to(here) > 0.1:
		print("oi")
		look_at(look_dir, up) #isso aqui tá dando problema
		rotate_y(PI)

func _ready():
	set_route()
	if has_vision:
		$Vision.visible = true
		#set_vision_range()

func set_destination(new_dest):
	adjust_facing(new_dest, up_vec)
	destination = new_dest

func move_to(destination, dt):
	var direction = destination - global_transform.origin
	direction = direction.normalized() * speed * dt
	velocity.x = direction.x
	velocity.z = direction.z

func add_ragdoll_to_level(exp_origin):
	var rag = ragdoll.instance()
	rag.set_as_toplevel(true) #serah que isso eh realmente necessario?
	
	var root_children = get_tree().get_root().get_children() # adiciona ele a arvore
	for child in root_children:
		var child_name = child.name
		if(child_name.begins_with("Level")):
			child.add_child(rag)
			break
	rag.transform.origin = transform.origin #instancia na mesma posicao que o objeto atual
	rag.translation.y = 1.5 #coloca o ragdoll na altura certa
	rag.explode(exp_origin) #chama a explosao

func explode(exp_origin):
	add_ragdoll_to_level(exp_origin)
	emit_signal("died")
	queue_free()

func change_destination():
	initial_point+=1
	if initial_point < route_pos.size():
		set_destination(route_pos[initial_point])
	elif loop:
		initial_point = 0
		set_destination(route_pos[initial_point])
	else:
		emit_signal("reached_destination")
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
			move_to(destination, delta) #set velocity to move to point
		else:
			change_destination()
	
	velocity = move_and_slide(velocity, up_vec)
	
#	if need_facing_adjust:
#		adjust_facing(velocity, up_vec)
	
#	var hitCount = get_slide_count()
#
#	if(hitCount > 0):
#		var collision = get_slide_collision(0)
#		if collision.collider is RigidBody:
#			collision.collider.apply_impulse(collision.position, -collision.normal)

func _on_Vision_body_entered( body ):
	if(body.name == "Beyblade"):
		emit_signal("spotted")
