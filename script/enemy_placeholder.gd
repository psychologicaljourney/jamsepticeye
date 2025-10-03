extends Node2D

var health = 100

func _ready():
	add_to_group("Enemy")

func on_hit(_area) -> void:
	health -= 25
	if health <= 0:
		queue_free()
