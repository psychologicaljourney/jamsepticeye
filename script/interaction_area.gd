extends Area2D


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		var interactions = get_overlapping_areas()
		if len(interactions) > 0: 
			interactions[0].trigger()
