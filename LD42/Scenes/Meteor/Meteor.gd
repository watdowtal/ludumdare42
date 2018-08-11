extends Area2D

func _physics_process(delta):
	var areas = get_overlapping_areas()
	for area in areas:
		if area.is_in_group("Player"):
			area.get_parent().damage()