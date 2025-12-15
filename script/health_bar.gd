extends ProgressBar

@export var living: Living

func _ready() -> void:
	max_value = living.max_health
	value = living.max_health
	living.health_changed.connect(health_changed)

func health_changed(health: float):
	value = health
