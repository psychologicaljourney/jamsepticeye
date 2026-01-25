extends Node

const BulletDamage = 25
const BulletDamageUp = 50

@onready var player: Player = get_tree().get_first_node_in_group("Player")
@onready var damage_over_time = preload("res://scene/weapons/bullets/damage_over_time.tscn")
var hit_particle = preload("res://scene/particles/hit_particle.tscn")

var weapon_info = {
	"shotgun" : preload("res://data/weapon_info/shotgun.tres"),
	"fellrifle" : preload("res://data/weapon_info/fellrifle.tres")
}

# func write_dialogue():
	#OS.shell_open("D:\SteamLibrary\steamapps\common\Library Of Ruina\LibraryOfRuina.exe")
	#await get_tree().create_timer(0.5).timeout
	#get_window().grab_focus() # maaan
	#OS.alert("Then Write.")
# Let's not. (Maybe (Unless there will be a good idea (There won't be (Most likely))))

func _ready() -> void:
	randomize()

func get_player_dir(pos: Vector2) -> Vector2:
	return Vector2(player.global_position.x - pos.x,player.global_position.y - pos.y)
