extends Weapon

@export var damage: float = 1
@export_range(1, 1000, 1) var bullet_amount: int = 1
@export var fire_area: Area2D
@export var target_scene: PackedScene
@export var firerate := 1.0
@export var alt_firerate := 10.0
@export var target_limit := 5

func shoot():
	if can_shoot:
		can_shoot = false
		var bodies = fire_area.get_overlapping_bodies()
		var limit = len(bodies) if len(bodies) <= target_limit else target_limit
		for i in range(limit):
			if bodies[i] is Living:
				bodies[i].damage(damage)
		await get_tree().create_timer(firerate).timeout
		can_shoot = true

func shoot_alt():
	if can_shoot_alt:
		can_shoot_alt = false
		$AnimationPlayer.play("shoot_alt")
		Global.player.speed_mult = 0
		await get_tree().create_timer(1).timeout
		var bodies = fire_area.get_overlapping_bodies()
		var limit = len(bodies) if len(bodies) <= target_limit else target_limit
		if limit != 0:
			bodies[0].damage(50)
			bodies[0].add_child(target_scene.instantiate())
			await get_tree().create_timer(1).timeout
			for i in range(1,limit):
				var d = Global.damage_over_time.instantiate()
				bodies[i].add_child(d)
				d.start(1, .04, 30)
		Global.player.speed_mult = 1
		await get_tree().create_timer(alt_firerate).timeout
		can_shoot_alt = true
		
