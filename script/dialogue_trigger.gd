@icon("res://sprite/d_icon.svg")
class_name DialogueTrigger extends Interactable

@export var dialogue: DialogueResource
@export var title: String

@export var node: Node
@export var function_to_execute: String

func _ready() -> void:
	$TextureRect.hide()

func trigger():
	var d: DialogueBalloon = DialogueManager.show_dialogue_balloon(dialogue, title)
	$TextureRect.hide()
	d.global_position = global_position
	Global.player.sprite_look_at(global_position)
	
	d.tree_exiting.connect(dialogue_finished)
	d.started_typing.connect(started_typing)
	d.finished_typing.connect(finished_typing)
	
	if function_to_execute == "Talk" and node is AnimatedSprite2D: # scuffed but a
		node.play("talk")
		d.tree_exiting.connect(func(): node.play("idle"))

func dialogue_finished():
	$TextureRect.show()

func started_typing():
	if function_to_execute == "Talk" and node is AnimatedSprite2D:
		node.play("talk")

func finished_typing():
	if function_to_execute == "Talk" and node is AnimatedSprite2D:
		node.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$TextureRect.show()


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		$TextureRect.hide()
