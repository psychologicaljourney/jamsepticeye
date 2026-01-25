class_name PlayerJump
extends State

@export var player: Player

func enter():
	player.sprite.play("jump")
	if player.jumps > 0:
		player.jumps -= 1
		player.velocity.y = player.jump_vel * player.speed_mult
	

func input(_input: InputEvent):
	if Input.get_axis("left", "right") != 0:
		player.state_machine.change_state("Walk")
	else:
		player.state_machine.change_state("Idle")
