class_name PlayerWalk
extends State


@export var player: Player

func enter():
	player.sprite.play("walk")

func physics_update(_delta: float):
	
	var direction := Input.get_axis("left", "right")
	if direction:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)
		player.state_machine.change_state("Idle")

func input(_event):
	if Input.is_action_just_pressed("jump"):
		player.state_machine.change_state("Jump")
