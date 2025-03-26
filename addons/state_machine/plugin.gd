@tool
extends EditorPlugin

var state_machine_script: Script
var state_script: Script
var global_state_machine_script: Script

func _enter_tree():
	state_machine_script = preload("res://addons/state_machine/state_machine.gd")
	state_script = preload("res://addons/state_machine/state.gd")
	global_state_machine_script = preload("res://addons/state_machine/global_state_machine.gd")
	
	add_custom_type("StateMachine", "Node", state_machine_script, preload("res://addons/state_machine/assets/icon.svg"))
	add_custom_type("State", "BaseState", state_script, preload("res://addons/state_machine/assets/icon_state.svg"))
	add_custom_type("GlobalStateMachine", "Node", global_state_machine_script, preload("res://addons/state_machine/assets/icon_global.svg"))

func _exit_tree():
	remove_custom_type("StateMachine")
	remove_custom_type("State")
	remove_custom_type("GlobalStateMachine")
