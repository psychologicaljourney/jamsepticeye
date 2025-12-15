class_name Player
extends CharacterBody2D


var speed = 150
var jump_vel = -200

var speed_mult := 1.0

var max_jumps := 2
@onready var jumps := max_jumps

@export var sprite: AnimatedSprite2D
@export var state_machine: StateMachine
@export var camera: Camera2D

func _process(_delta: float) -> void:
	if velocity.x > 0:
		$Sprite.flip_h = false
	elif velocity.x < 0:
		$Sprite.flip_h = true

func sprite_look_at(pos: Vector2):
	if global_position.x > pos.x:
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		jumps = max_jumps

	move_and_slide()
