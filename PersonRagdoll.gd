extends RigidBody

func _ready():
	pass

func explode(exp_origin):
	print("explodi")
	var col_transform = $CollisionShape.transform
	var intensity = 1/col_transform.origin.distance_to(exp_origin)
	var impulse_dir = col_transform.origin - exp_origin
	apply_impulse(col_transform.origin, impulse_dir*intensity)