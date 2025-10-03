class_name Player
extends CharacterBody2D


var speed = 150
var jump_vel = -200

@export var sprite: AnimatedSprite2D
@export var state_machine: StateMachine

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()
	
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true
