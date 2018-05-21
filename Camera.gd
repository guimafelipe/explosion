extends Camera

onready var target = get_parent()
var smooth_speed = 4.5
export var offset = Vector3(0, -2, 10)
const up = Vector3(0, 1, 0)

func _process(delta):
#	_late_process(delta)
	pass

func _physics_process(delta):
	var target_pos = target.global_transform.origin
	var desired_pos = target_pos + offset
	translation = translation.linear_interpolate(desired_pos, delta*smooth_speed)
	look_at(target_pos, up)

func _ready():
	offset = translation
	set_as_toplevel(true)
