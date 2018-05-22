extends RigidBody

const up_impulse = 1

func _ready():
	pass

func explode(exp_origin):
	var col_transform = $CollisionShape.global_transform
	var col_center = col_transform.origin
	var intensity = 1/col_center.distance_to(exp_origin)
	intensity *= 15
	var impulse_dir = col_center - exp_origin
	impulse_dir.y += intensity * up_impulse
	apply_impulse(col_transform.origin, impulse_dir*intensity)