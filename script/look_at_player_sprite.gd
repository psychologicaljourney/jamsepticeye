extends Node2D

@export var flip: bool = false

func _process(_delta: float) -> void:
	if Global.player.global_position.x > global_position.x:
		scale.x = 1 if !flip else -1
	else:
		scale.x = -1 if !flip else 1
