class_name Living extends CharacterBody2D

@export var sprite: AnimatedSprite2D
@export var max_health := 100.0
@export var hit_particle_color: GradientTexture1D = preload("res://scene/misc/default_hit_gradient.tres")
@onready var health = max_health

var hit_effect_timer: Timer
var hit_material = preload("res://scene/shaders/hit_shader.tres")
signal health_changed

func _ready() -> void:
	add_to_group("Living")
	if sprite != null:
		sprite.material = hit_material
	
	hit_effect_timer = Timer.new()
	hit_effect_timer.one_shot = true
	hit_effect_timer.wait_time = 0.2
	hit_effect_timer.timeout.connect(reset_hit_effect)
	add_child(hit_effect_timer)

func damage(amount: float):
	set_health(health-amount)
	hit_anim()
	hit_particle()

func reset_hit_effect():
	if sprite == null: return
	sprite.set_instance_shader_parameter("hit", false)
	sprite.set_instance_shader_parameter("hit_color", Color(1,1,1,1))
	
func set_hit_color(col: Color):
	if sprite == null: return
	sprite.set_instance_shader_parameter("hit_color", col)

func hit_anim():
	if sprite == null: return
	sprite.set_instance_shader_parameter("hit", true)
	hit_effect_timer.start()
	
func heal(amount: float):
	set_health(health+amount)

func hit_particle():
	var h: GPUParticles2D = Global.hit_particle.instantiate()
	h.global_position = global_position
	h.process_material.color = hit_particle_color.gradient.sample(randf_range(0, 1))
	get_tree().root.add_child(h)
	h.emitting = true

func set_health(val: float):
	health = clampf(val, 0, max_health)
	if health <= 0 and not self is Player:
		die()
	health_changed.emit(health)

func die():
	queue_free()
