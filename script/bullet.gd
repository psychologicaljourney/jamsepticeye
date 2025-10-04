extends Node2D
const speed = 300
func _ready():
	add_to_group("projectile")
func _process(delta: float):
	position +=  transform.x * speed * delta
func off_screen():
	queue_free()
func hit_enemy(_body):
	queue_free()
