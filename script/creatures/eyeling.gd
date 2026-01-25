extends Living


@export var eye: Sprite2D

@export var speed: float = 5.0
@export_range(0.0, 16.0, 0.5) var max_distance = 5.0

var target: Vector2 = Vector2.ZERO
var target_smooth: Vector2 = Vector2.ZERO


func _process(delta: float) -> void:
	target = Global.player.global_position
	target_smooth = target_smooth.lerp(target, speed * delta)
	
	var mat := eye.material as ShaderMaterial
	var offset: Vector2 = target_smooth - eye.global_position
	
	var dist: float = offset.length()
	if dist > max_distance:
		offset = offset / dist * max_distance
	mat.set_shader_parameter("offset", Vector2i(offset.round()))
