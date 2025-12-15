class_name Living
extends CharacterBody2D


@export var max_health := 100.0
@onready var health = max_health

signal health_changed

func damage(amount: float):
	set_health(health-amount)

func heal(amount: float):
	set_health(health+amount)

func set_health(val: float):
	health = clampf(val, 0, max_health)
	health_changed.emit(health)
