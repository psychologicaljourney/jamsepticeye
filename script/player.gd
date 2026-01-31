class_name Player extends Living


var speed = 150
var jump_vel = -230

var speed_mult := 1.0

var max_jumps := 1
@onready var jumps := max_jumps

@export var state_machine: StateMachine
@export var camera: Camera2D

func _process(_delta: float) -> void:
	if velocity.x > 0:
		sprite.flip_h = false
	elif velocity.x < 0:
		sprite.flip_h = true

func _input(_event: InputEvent) -> void:
	if state_machine.current_state != PlayerTalk:
		if Input.is_action_pressed("down"):
			set_collision_mask_value(7, false)
			global_position.y += 1
		elif Input.is_action_just_released("down"):
			set_collision_mask_value(7, true)

func sprite_look_at(pos: Vector2):
	if global_position.x > pos.x:
		sprite.flip_h = true
	else:
		sprite.flip_h = false

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if is_on_floor():
		jumps = max_jumps

	move_and_slide()
