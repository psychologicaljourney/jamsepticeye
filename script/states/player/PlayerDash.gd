class_name PlayerDash
extends State

@export var player: Player
var cooldown

func enter():
	player.sprite.play("walk")
	$DashTimer.start()
	player.speed *= 3
func DashTimerOut():
	player.speed = 150
func physics_update(_delta: float):
	if Input.get_axis("left", "right") != 0:
			player.state_machine.change_state("Walk")
	else:
			player.state_machine.change_state("Idle")
