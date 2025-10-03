class_name PlayerIdle
extends State


@export var player: Player

func enter():
	player.sprite.play("idle")

func physics_update(_delta: float):
	player.velocity = Vector2.ZERO

func input(_event: InputEvent):
	if Input.get_axis("left", "right") != 0:
		player.state_machine.change_state("Walk")
	if Input.is_action_just_pressed("jump"):
		player.state_machine.change_state("Jump")
