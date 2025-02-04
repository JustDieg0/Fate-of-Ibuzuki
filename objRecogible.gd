extends Area2D

@export var obj : String = ""

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		Global.reconocer_obj(obj)
		queue_free()
