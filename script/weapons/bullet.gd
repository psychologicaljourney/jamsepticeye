extends Node2D

@export var speed: float = 300
@export var time: float = 3

var timer: Timer

func _ready():
	add_to_group("Bullet")
	
	timer = Timer.new()
	add_child(timer)
	timer.timeout.connect(queue_free)
	timer.start(time)
	
func _process(delta: float):
	position +=  transform.x * speed * delta


func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("Living"):
		body.damage(10)
		queue_free()
