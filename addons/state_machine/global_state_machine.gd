class_name GlobalStateMachine
extends Node

var active_states: Array = []
signal global_state_changed(new_state)

func add_global_state(state: State):
	if state not in active_states:
		active_states.append(state)
		state.enter()
		emit_signal("global_state_changed", state)

func remove_global_state(state: State):
	if state in active_states:
		state.exit()
		active_states.erase(state)
		emit_signal("global_state_changed", null)

func _process(delta):
	for state in active_states:
		state.update(delta)
