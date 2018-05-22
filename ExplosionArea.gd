extends Area

func _ready():
	pass

func explode():
	var exploded_items = get_overlapping_bodies()
	print(exploded_items)
	for item in exploded_items:
		if item.is_in_group("ExplodeReceptor"):
			item.explode(global_transform.origin)