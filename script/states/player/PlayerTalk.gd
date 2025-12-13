class_name PlayerTalk
extends State


@export var player: Player

func enter():
	player.velocity = Vector2.ZERO
	#player.sprite.play("talk")
