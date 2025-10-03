class_name StateMachine
extends Node

@export var init_state: State

var current_state: State
var states : Dictionary = {}

func _ready():
	for state in get_children():
		if state is State:
			states[state.name] = state
			state.switched.connect(on_state_switched)
	if init_state:
		init_state.enter()
		current_state = init_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _input(event: InputEvent):
	if current_state:
		current_state.input(event)

func change_state(new_state):
	on_state_switched(current_state, new_state)

func on_state_switched(state, next_state_name):
	if state != current_state: return
	
	var new_state = states.get(next_state_name)
	if !new_state: return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
