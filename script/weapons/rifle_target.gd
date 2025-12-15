extends Node2D


func _ready() -> void:
	$AnimationPlayer.play("fire")
	await get_tree().create_timer(1).timeout
	$CPUParticles2D.emitting = true
	var l: Living = get_parent()
	for i in range(40):
		l.damage(1)
		await get_tree().create_timer(0.04).timeout
	await get_tree().create_timer(2).timeout
	$AnimationPlayer.play("leave")
	await get_tree().create_timer(1).timeout
	queue_free()
