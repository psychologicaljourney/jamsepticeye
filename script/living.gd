class_name Living
extends CharacterBody2D

@export var sprite: Sprite2D
@export var max_health := 100.0
@onready var health = max_health

var hit_effect_timer: Timer

signal health_changed

func _ready() -> void:
	hit_effect_timer = Timer.new()
	hit_effect_timer.one_shot = true
	hit_effect_timer.wait_time = 0.2
	hit_effect_timer.timeout.connect(reset_hit_effect)
	add_child(hit_effect_timer)

func damage(amount: float):
	set_health(health-amount)
	hit_anim()

func reset_hit_effect():
	sprite.set_instance_shader_parameter("hit", false)
	sprite.set_instance_shader_parameter("hit_color", Color(1,1,1,1))
	
func set_hit_color(col: Color):
	sprite.set_instance_shader_parameter("hit_color", col)

func hit_anim():
	sprite.set_instance_shader_parameter("hit", true)
	hit_effect_timer.start()
	
func heal(amount: float):
	set_health(health+amount)

func set_health(val: float):
	health = clampf(val, 0, max_health)
	health_changed.emit(health)
