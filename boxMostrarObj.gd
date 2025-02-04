extends HBoxContainer

@export var animaton_box : AnimationPlayer 

func _ready() -> void:
	$Label.text = str(Global.leaf)

func _on_animation_box_animation_finished(anim_name: StringName) -> void:
	if anim_name == "bajar" :
		$Timer.start()
	elif anim_name == "subir":
		queue_free()

func _on_timer_timeout() -> void:
	if animaton_box:
		animaton_box.play("subir")
	else:
		queue_free()
