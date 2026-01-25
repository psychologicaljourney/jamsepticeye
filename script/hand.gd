extends Node2D

@export var weapon_ui_label: Label
@export var weapon_ui_texture: TextureRect
@export var weapon_info_panel : Panel

var cursor_velocity := Vector2.ZERO
var mouse_pos: Vector2

var weapon_index = {1 : Global.weapon_info["shotgun"], 
				2 : Global.weapon_info["fellrifle"] } # Child id (starts at 1) : Gun Resource

var held = 1

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func update_ui(info: WeaponInfo):
	weapon_ui_label.text = info.weapon_name.to_upper()
	weapon_ui_texture.texture = info.info_texture

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
		var i = get_child(held)
		if i.visible and i is Weapon:
			i.shoot()

	if Input.is_action_pressed("shoot_alt"):
		var i = get_child(held)
		if i.visible and i is Weapon:
			i.shoot_alt()

	for i in range(1, len(weapon_index.values())+1):
		if Input.is_key_label_pressed(KEY_0+i):
			if i != held:
				update_ui(weapon_index[i])
				get_child(held).hide()
				get_child(i).show()
				held = i
