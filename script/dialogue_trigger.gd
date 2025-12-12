@icon("res://sprite/d_icon.svg")
class_name DialogueTrigger
extends Interactable

@export var dialogue: DialogueResource
@export var title: String

func _ready() -> void:
	$TextureRect.hide()

func trigger():
	var d = DialogueManager.show_dialogue_balloon(dialogue, title)
	d.global_position = global_position

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$TextureRect.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$TextureRect.hide()
