class_name WalkingCreature extends Living

#TODO: implement jumping
#TODO: wandering
@export var tracking_area: Area2D #If the target is in the area it'll start following it
@export var walkspeed: float = 25.0
@export var chasespeed: float = 50.0
@export var target_group: StringName = "Player"

@export var can_walk: bool = true #aka only apply gravity if false
@export var stop_offset: Vector2 = Vector2.ZERO
@export var ignore_after_out_of_range: bool = false
@export var min_walk_time: float = 4.0
@export var max_walk_time: float = 6.0

@export var directional_node: Node2D #stuff that should be rotated (rotating the entire char2d node is a bad idea btw)

var looking_left := false
var target: Living
var target_priority: bool = false #True if the target is still in the tracking area, false otherwise (unused, still need to implement multitargeting which isnt important rn)
var walk_timer: Timer
var walking := false
var current_direction: Vector2 = Vector2.ZERO


func _ready() -> void:
	super._ready()
	randomize()
	
	tracking_area.body_entered.connect(tracking_entered)
	tracking_area.body_exited.connect(tracking_left)
	
	walk_timer = Timer.new()
	walk_timer.wait_time = randf_range(min_walk_time, max_walk_time)
	walk_timer.timeout.connect(wander)
	add_child(walk_timer)
	walk_timer.start()
	
func tracking_entered(body):
	if body.is_in_group(target_group):
		if !target:
			target = body
			walking = true
			target_priority = true
			sprite.play("walk") # because for SOME REASON the thing in process doesnt work on the first try

func tracking_left(body):
	if body == target and ignore_after_out_of_range:
		target = null
		walking = false
		target_priority = false
		velocity = Vector2.ZERO
		sprite.play("idle")

func _process(_delta: float) -> void:
	if walking or wandering:
		if sprite.animation == "idle":
			sprite.play("walk")
	elif sprite.animation == "walk":
			sprite.play("idle")

	if directional_node:
		if looking_left and current_direction.x == 1:
			looking_left = false
			directional_node.scale.x = 1
		elif !looking_left and current_direction.x == -1:
			looking_left = true
			directional_node.scale.x = -1

func walk():
	if target:
		if !walking:
			walking = true
			walk_timer.stop()
		current_direction.x = get_target_direction(stop_offset)
		velocity.x = current_direction.x * chasespeed
	else: #Wander
		if walking:
			walking = false
			walk_timer.start()

		
var wandering = false
func wander():
	if wandering:
		wandering = false
		velocity.x = 0.0
	else:
		wandering = true
		current_direction.x = randi_range(0,1) * 2 - 1
		velocity.x = current_direction.x * walkspeed
		
	walk_timer.wait_time = randf_range(min_walk_time, max_walk_time)

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
