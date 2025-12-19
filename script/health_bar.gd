class_name HealthBar extends ProgressBar

@export var living: Living

func _ready() -> void:
	max_value = living.max_health
	value = living.max_health
	living.health_changed.connect(health_changed)
	z_index = 20

func health_changed(health: float):
	value = health
