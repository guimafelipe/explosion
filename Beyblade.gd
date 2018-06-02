extends KinematicBody

var speed = 500
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

var PersonClass = load("res://Person.gd")

signal died

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_action_just_pressed("explode")):
		explode()

func change_camera_parent():
	var par_dest = get_node("..")
	var par_or = $Target
	var camera = $Target/Camera
	par_or.remove_child(camera)
	par_dest.add_child(camera)

func explode():
	change_camera_parent()
	$ExplosionArea.explode()
	yield(get_tree(), "idle_frame")
#	print("morri")
	emit_signal("died")
	queue_free()

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	if $Target.get_child_count() > 0:
		var camera = $Target/Camera
		var cam_xform = camera.get_global_transform()
		if (Input.is_action_pressed("move_up")):
			direction += -cam_xform.basis[2]
		if (Input.is_action_pressed("move_down")):
			direction += cam_xform.basis[2]
		if (Input.is_action_pressed("move_left")):
			direction += -cam_xform.basis[0]
		if (Input.is_action_pressed("move_right")):
			direction += cam_xform.basis[0]
	direction = direction.normalized()
	direction = direction * speed * delta
	
	velocity.y += gravity * delta
	velocity.x = direction.x
	velocity.z = direction.z
	
	if velocity.y > 0:
		gravity = -20
	else:
		gravity = -30
	
	velocity = move_and_slide(velocity, Vector3(0, 1, 0))
	
	if is_on_floor() and Input.is_key_pressed(KEY_SPACE):
		velocity.y = 10 #jump
	
	var hitCount = get_slide_count()

	if(hitCount > 0):
		var collision = get_slide_collision(0)
		if collision.collider is RigidBody:
			collision.collider.apply_impulse(collision.position, -collision.normal)
		elif collision.collider is PersonClass:
			if collision.collider.exploderous:
				explode()
