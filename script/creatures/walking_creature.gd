class_name WalkingCreature extends Living

#TODO: implement jumping
#TODO: wandering
@export var tracking_area: Area2D #If the target is in the area it'll start following it
@export var walkspeed: float = 50.0
@export var target_group: StringName = "Player"
@export var can_walk: bool = true #aka only apply gravity if false
@export var stop_offset: Vector2 = Vector2.ZERO
@export var ignore_after_out_of_range: bool = false

var target: Living
var target_priority: bool = false #True if the target is still in the tracking area, false otherwise (unused, still need to implement multitargeting which isnt important rn)
var walk_timer: Timer
var walking := false

func _ready() -> void:
	super._ready()
	tracking_area.body_entered.connect(tracking_entered)
	tracking_area.body_exited.connect(tracking_left)
	walk_timer = Timer.new()
	
	add_child(walk_timer)
	
func tracking_entered(body):
	if body.is_in_group(target_group):
		if !target:
			target = body
			walking = true
			target_priority = true

func tracking_left(body):
	if body == target and ignore_after_out_of_range:
		target = null
		walking = false
		target_priority = false
		velocity = Vector2.ZERO
		sprite.play("idle")

func _process(_delta: float) -> void:
	if walking:
		if sprite.animation == "idle":
			sprite.play("walk")
			

func walk():
	if target:
		walking = true
		velocity.x = get_target_direction(stop_offset) * walkspeed
	else:
		pass

func get_target_direction(offset: Vector2 = Vector2.ZERO) -> int:
	if target:
		if target.global_position.x > global_position.x + offset.x:
			return 1
		elif target.global_position.x < global_position.x - offset.x:
			return -1
	return 0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if can_walk:
		walk()
	
	move_and_slide()
