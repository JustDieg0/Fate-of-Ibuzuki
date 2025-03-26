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

func _init(owner:Node) -> void:
	spc_timer = Timer.new()
	ult_timer = Timer.new()
	spc_timer.one_shot = true
	ult_timer.one_shot = true
	owner.add_child(self)
	self.add_child(spc_timer)
	self.add_child(ult_timer)

func _exit_tree() -> void:
	pass
