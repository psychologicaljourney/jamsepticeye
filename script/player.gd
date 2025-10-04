class_name Player
extends CharacterBody2D


var speed = 150
var jump_vel = -200
var jumps_left = 2
@export var sprite: AnimatedSprite2D
@export var state_machine: StateMachine

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
