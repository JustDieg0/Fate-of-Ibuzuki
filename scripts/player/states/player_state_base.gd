class_name PlayerStateBase
extends State

var player: Player:
	set(val):
		controlled_node = val
	get:
		return controlled_node
