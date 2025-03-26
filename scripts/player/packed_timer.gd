class_name PackedTimer
extends Node

var spc_timer : Timer :
	set(val):
		spc_timer = val
	get:
		return spc_timer

var ult_timer : Timer : 
	set(val):
		ult_timer = val
	get:
		return ult_timer

func _init() -> void:
	spc_timer = Timer.new()
	ult_timer = Timer.new()
