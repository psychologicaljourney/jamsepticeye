class_name PlayerJump
extends State


@export var player: Player

func enter():
	player.sprite.play("jump")
	player.velocity.y = player.jump_vel
	

func physics_update(_delta: float):
	if player.is_on_floor():
	
		if Input.get_axis("left", "right") != 0:
			player.state_machine.change_state("Walk")
		else:
			player.state_machine.change_state("Idle")
