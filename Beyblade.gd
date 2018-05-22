extends KinematicBody

var speed = 500
var direction = Vector3()
var gravity = -9.8
var velocity = Vector3()

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _process(delta):
	if(Input.is_action_just_pressed("explode")):
		$ExplosionArea.explode()

func _physics_process(delta):
	direction = Vector3(0, 0, 0)
	var cam_xform = get_node("Target/Camera").get_global_transform()
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
		velocity.y = 10
	
	var hitCount = get_slide_count()
	
	if(hitCount > 0):
		var collision = get_slide_collision(0)
		if collision.collider is RigidBody:
			collision.collider.apply_impulse(collision.position, -collision.normal)