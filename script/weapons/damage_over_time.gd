extends Node2D



func start(damage: float, wait: float, amount: int):
	if !get_parent() is Living: 
		queue_free()
		return
	var l: Living = get_parent()
	for i in range(amount):
		l.damage(damage)
		await get_tree().create_timer(wait).timeout
	queue_free()
		
