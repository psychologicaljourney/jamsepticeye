extends GPUParticles2D


@onready var player: Player = get_tree().get_first_node_in_group("Player")
func _process(_delta: float) -> void:
	global_position.x = player.global_position.x
