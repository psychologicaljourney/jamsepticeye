class_name PlayerWalk
extends State


@export var player: Player
var DashCooldown
func enter():
	player.sprite.play("walk")

func physics_update(_delta: float):
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed * player.speed_mult
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.state_machine.change_state("Idle")

func input(_event):
	if Input.is_action_just_pressed("jump"):
		player.state_machine.change_state("Jump")
	if Input.is_action_just_pressed("dash"):
		if not DashCooldown:
			player.state_machine.change_state("Dash")
			DashCooldown = true
			$"../Dash/DashCooldown".start()
func DashCooldownOut():
	DashCooldown = false
