class_name Gun
extends Node2D

@export var bullet: PackedScene
@export var firerate: float = 1
@export var bullet_amount: int = 1
@export var firepoint: Node2D
@export_range(0, 360, 1) var arc_deg: float = 0
@onready var arc = deg_to_rad(arc_deg)
var can_shoot := true

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
