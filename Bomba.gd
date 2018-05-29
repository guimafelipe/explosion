extends RigidBody

var exploded = false

func explode(exp_origin):
	if not exploded:
		exploded = true
		$ExplosionArea.explode()
	queue_free()

#func _process(delta):
#	if(Input.is_action_just_pressed("explode")):
#		$ExplosionArea.explode()

