class_name AttackingCreature extends WalkingCreature


@export var attacking_area: Area2D
@export var range_area: Area2D
@export var atk_damage: float = 10.0
@export var atk_time: float = .5 #time the attack collision is active
@export var windup: float = 1.0 #windup before animation starts
@export var animation_windup: float = .125 #windup of the animation itself

var attacking := false

func _ready() -> void:
	super._ready()
	attacking_area.monitoring = false
	attacking_area.body_entered.connect(body_entered)
	range_area.body_entered.connect(body_in_range)
		
func body_in_range(_body):
	if !attacking:
		attacking = true
		range_area.set_deferred("monitoring", false)
		await get_tree().create_timer(windup).timeout
		attack()

func body_entered(body):
	if body is Living:
		body.damage(atk_damage)

func attack():
	if !attacking_area.monitoring:
		sprite.play("attack")
		if animation_windup > 0:
			await get_tree().create_timer(animation_windup).timeout
		attacking_area.monitoring = true
		await get_tree().create_timer(atk_time).timeout
		if walking:
			sprite.play("walk")
		else:
			sprite.play("idle")
		attacking_area.set_deferred("monitoring", false)
		range_area.monitoring = true
		attacking = false
