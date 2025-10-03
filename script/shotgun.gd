extends Node2D

const bullet = preload("res://scene/bullet.tscn")
var BulletCooldown
var mouse_pos
var cursor_velocity = Vector2.ZERO

func _process(delta):
	cursor_velocity = Input.get_vector("mouse_left", "mouse_right", "mouse_up", "mouse_down")
	cursor_velocity = cursor_velocity.limit_length()
	mouse_pos = get_viewport().get_mouse_position()
	Input.warp_mouse(mouse_pos + cursor_velocity * 2500 * delta)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	look_at(get_global_mouse_position())
	rotation_degrees = wrap(rotation_degrees, 0, 360)
	if rotation_degrees > 90 and rotation_degrees < 270:
		scale.y = -1
	else:
		scale.y = 1
	if Input.is_action_just_pressed("shoot"):
		if not BulletCooldown:
			BulletCooldown = true
			var bullet_instance = bullet.instantiate()
			$Cooldown.start()
			get_tree().root.add_child(bullet_instance)
			bullet_instance.global_position = $Marker2D.global_position
			bullet_instance.rotation = rotation

func ShootCooldown():
	BulletCooldown = false
