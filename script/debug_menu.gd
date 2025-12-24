extends Control

@export var spawn_list: ItemList

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug"):
		if !visible:
			show()
		else:
			hide()


func _on_item_list_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var path = "res://scene/creatures/"+spawn_list.get_item_text(index)+".tscn"
	var n: PackedScene = load(path)
	var c: Living = n.instantiate()
	c.global_position = Global.player.global_position + Vector2(0, -100)
	get_tree().root.add_child(c)
	
