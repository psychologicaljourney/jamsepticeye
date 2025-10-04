extends Node2D

var health = 100


func _ready():
	add_to_group("Enemy")

	



func on_hit(_area) -> void:
	health = health - $"/root/Global".BulletDamage
	if health <= 0:
		queue_free()


	
