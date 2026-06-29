extends Node
class_name StateMachine

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transition.connect(TransitionToState)
	if initial_state:
		initial_state.OnStateEnter()
		current_state = initial_state

func _process(delta):
	current_state.Update(delta)

func _physics_process(delta):
	current_state.PhysicsUpdate(delta)

func TransitionToState(new_state_name):
	# grab new state
	var new_state: State = states.get(new_state_name.to_lower())
	if !new_state:
		return
	# exit current state
	if current_state:
		current_state.OnStateExit()
	# enter next state
	#print(str(current_state), " -> ", str(new_state))
	current_state = new_state
	new_state.OnStateEnter()
