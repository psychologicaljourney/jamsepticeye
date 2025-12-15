extends Node

const BulletDamage = 25
const BulletDamageUp = 50

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var damage_over_time = preload("res://scene/weapons/bullets/damage_over_time.tscn")

# func write_dialogue():
	#OS.shell_open("notepad.exe")
	#await get_tree().create_timer(0.5).timeout
	#get_window().grab_focus() # maaan
	#OS.alert("Then Write.")
# Let's not. (Maybe (Unless there will be a good idea (There won't be (Most likely))))
