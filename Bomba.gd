extends RigidBody

var exploded = false
signal exploded

func explode(exp_origin):
	if not exploded:
		exploded = true
		$ExplosionArea.explode()
		emit_signal("exploded")
	queue_free()

#func _process(delta):
#	if(Input.is_action_just_pressed("explode")):
#		$ExplosionArea.explode()

