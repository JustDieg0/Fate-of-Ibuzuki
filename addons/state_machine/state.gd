## Estado base para la máquina de estados.
##
## Recomienda implementar los siguientes métodos:
## - `on_process(delta: float)`: Se llama en cada frame.
## - `on_physics_process(delta: float)`: Se llama en cada paso de física.
## - `on_input(event: InputEvent)`: Se llama cuando se recibe una entrada.

class_name State
extends Node


var controlled_node:Node
var state_machine: StateMachine
var sub_state_machine: StateMachine = null
signal state_finished(new_state)

func start():
	if sub_state_machine:
		sub_state_machine.current_state.start()

func end():
	if sub_state_machine and sub_state_machine.current_state:
		sub_state_machine.current_state.end()

func change_state(new_state: String):
	if state_machine:
		state_machine.change_state(new_state)
		emit_signal("state_finished", new_state)
