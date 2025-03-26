class_name StateMachine
extends Node

## nodo que vamos a controlar
@onready var controller_node = self.owner

## estado inicial o por defecto
@export var default_state: State

## estado actual
var current_state: State = null

## señal de cambio de estado
signal state_changed(new_state)

func _state_default_start() -> void:
	current_state = default_state
	_state_start()

func _state_start() -> void:
	prints("StateMachine", controller_node.name, "start state", current_state.name)
	## configuración del estado
	current_state.controlled_node = controller_node
	current_state.state_machine = self
	current_state.start()

func _ready():
	call_deferred("_state_default_start")

func change_state(state_name: String):
	if current_state and current_state.has_method("end"): current_state.end()
	current_state = get_node(state_name)
	emit_signal("state_changed", current_state)
	_state_start()

#region sobreescribimos los metodos de godot del nodo

func _process(delta:float) -> void:
	if current_state and current_state.has_method("on_process"):
		current_state.on_process(delta)
		
func _physics_process(delta:float) -> void:
	if current_state and current_state.has_method("on_physics_process"):
		current_state.on_physics_process(delta)
		
func _input(event:InputEvent) -> void:
	if current_state and current_state.has_method("on_input"):
		current_state.on_input(event)
		
func _unhandled_input(event:InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_input"):
		current_state.on_unhandled_input(event)
		
func _unhandled_key_input(event:InputEvent) -> void:
	if current_state and current_state.has_method("on_unhandled_key_input"):
		current_state.on_unhandled_key_input(event)

#endregion
