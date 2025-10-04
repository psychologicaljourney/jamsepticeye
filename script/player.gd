class_name Player
extends CharacterBody2D


var speed = 150
var jump_vel = -200
var jumps_left = 2

var in_sign = false
var dialogue_shown = false

@export var sprite: AnimatedSprite2D
@export var state_machine: StateMachine
const DIALOGUE = preload("uid://dy8hu8mwduyi2")
@onready var main: Node2D = $".."

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jumps_left = 2
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = jump_vel
		jumps_left -= 1
	move_and_slide()
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true
	if in_sign:
		if Input.is_action_just_pressed("interact") and not dialogue_shown:
			dialogue_shown = true
			var dialogue_instance:Node2D = DIALOGUE.instantiate()
			main.add_child(dialogue_instance)
			dialogue_instance.position = Vector2(452.0, 555.0)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Player:
		in_sign =  true
	

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body is Player:
		in_sign = false
