extends Label

@export var velocidad_subida = 0

func _process(delta: float) -> void:
	position.y -= delta * velocidad_subida

func _on_timer_timeout() -> void:
	queue_free()
