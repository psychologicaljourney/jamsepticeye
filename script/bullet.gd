extends Node2D

const speed = 300

func _process(delta: float):
	position +=  transform.x * speed * delta
