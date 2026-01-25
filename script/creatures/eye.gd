extends Living

@export var lid: AnimatedSprite2D

var blinking := false

func _ready() -> void:
	blink()

func blink() -> void:
	if !blinking:
		blinking = true
		lid.play("blink")
		lid.animation_finished.connect(func(): blinking = false)

func die():
	pass
