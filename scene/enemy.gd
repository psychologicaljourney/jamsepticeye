extends CharacterBody2D

var detected = false
var player: Player
func _physics_process(delta: float) -> void:
	if detected:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * 100
	move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body is Player:
		detected = true
		player = body
