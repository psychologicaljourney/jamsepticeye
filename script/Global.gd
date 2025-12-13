extends Node

const BulletDamage = 25
const BulletDamageUp = 50

@onready var player: Player = get_tree().get_first_node_in_group("Player")

func write_dialogue():
	OS.shell_open("notepad.exe")
	await get_tree().create_timer(0.5).timeout
	get_window().grab_focus() # maaan
	OS.alert("Then Write.")
	
