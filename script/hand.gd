extends Node2D

var cursor_velocity := Vector2.ZERO
var mouse_pos: Vector2

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _process(delta: float) -> void:
	cursor_velocity = Input.get_vector("mouse_left", "mouse_right", "mouse_up", "mouse_down")
	cursor_velocity = cursor_velocity.limit_length()
	mouse_pos = get_viewport().get_mouse_position()
	Input.warp_mouse(mouse_pos + cursor_velocity * 2500 * delta)
	
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1

	if Input.is_action_pressed("shoot"):
		for i in get_children():
			if i.visible and i is Weapon:
				i.shoot()
				break
	if Input.is_action_pressed("shoot_alt"):
		for i in get_children():
			if i.visible and i is Weapon:
				i.shoot_alt()
				break
