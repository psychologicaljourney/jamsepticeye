extends Node2D


@export var sprite: AnimatedSprite2D
var target: Vector2
var speed: float = 0.25

@export var start: Node2D
@export var end: Node2D

var t: Timer

func _ready() -> void:
	randomize()
	position = pick_pos()
	print(position)
	target = pick_pos()
	sprite.play("walk")
	
	t = Timer.new()
	t.timeout.connect(timeout)
	add_child(t)
	t.start(randi_range(6, 10))
	

func _process(_delta: float) -> void:
	if target.x > global_position.x:
		global_position.x += speed
		if sprite.flip_h:
			sprite.flip_h = false
	if target.x < global_position.x:
		global_position.x -= speed
		if !sprite.flip_h:
			sprite.flip_h = true
	
	if target.x == position.x:
		sprite.play("idle")
		await get_tree().create_timer(randi_range(1, 5)).timeout
		target = pick_pos()
		sprite.play("walk")

func timeout():
	sprite.play("idle")
	await get_tree().create_timer(randi_range(1, 5)).timeout
	target = pick_pos()
	sprite.play("walk")

func pick_pos() -> Vector2:
	return Vector2(randf_range(start.global_position.x, end.global_position.x), start.global_position.y)
	
