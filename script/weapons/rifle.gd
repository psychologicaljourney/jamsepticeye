extends Weapon

@export var damage: float = 1
@export_range(1, 1000, 1) var bullet_amount: int = 1
@export var firepoint: Node2D

func shoot():
	pass

func shoot_alt():
	pass
