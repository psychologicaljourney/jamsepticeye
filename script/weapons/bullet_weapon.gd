class_name BulletWeapon
extends Weapon

@export var bullet: PackedScene
@export var firerate: float = 1
@export var bullet_amount: int = 1
@export var firepoint: Node2D
@export_range(0, 360, 1) var arc_deg: float = 0
@onready var arc = deg_to_rad(arc_deg)

@export_category("Alt Fire")
@export var alt_fire_enabled: bool = false
@export var alt_bullet: PackedScene
@export var alt_firerate: float = 1
@export var alt_bullet_amount: int = 1
@export var alt_firepoint: Node2D
@export_range(0, 360, 1) var alt_arc_deg: float = 0
@onready var alt_arc = deg_to_rad(arc_deg)




func shoot():
	if can_shoot:
		can_shoot = false
		if bullet_amount == 1:
			var b = bullet.instantiate()
			b.position = firepoint.global_position
			b.global_rotation = global_rotation
			get_tree().root.call_deferred("add_child", b)
		else:
			for i in bullet_amount:
				var b = bullet.instantiate()
				b.position = firepoint.global_position
				var inc = arc / (bullet_amount - 1)
				b.global_rotation = ( firepoint.global_rotation + inc * i - arc / 2)
				get_tree().root.call_deferred("add_child", b)
		await get_tree().create_timer(firerate).timeout
		can_shoot = true

func shoot_alt():
	if alt_fire_enabled:
		if can_shoot_alt:
			can_shoot_alt = false
			if alt_bullet_amount == 1:
				var b = alt_bullet.instantiate()
				b.position = alt_firepoint.global_position
				b.global_rotation = global_rotation
				get_tree().root.call_deferred("add_child", b)
			else:
				for i in alt_bullet_amount:
					var b = alt_bullet.instantiate()
					b.position = alt_firepoint.global_position
					var inc = alt_arc / (alt_bullet_amount - 1)
					b.global_rotation = ( alt_firepoint.global_rotation + inc * i - alt_arc / 2)
					get_tree().root.call_deferred("add_child", b)
			await get_tree().create_timer(alt_firerate).timeout
			can_shoot_alt = true
