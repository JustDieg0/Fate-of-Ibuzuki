extends Sprite2D

var fade_time = 0.4

@export var texto: String = ""

var tween:Tween = null

func _ready() -> void:
	$SingTextLabel.modulate.a = 0.0
	$SingTextLabel.display_text(texto,$SingTextLabel.scale.x)

func varidad_opacidad(value: float):
	if tween:
		tween.kill()
	
	tween = get_tree().create_tween()
	tween.tween_property($SingTextLabel,"modulate:a",value,fade_time)

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		varidad_opacidad(1.0)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		varidad_opacidad(0.0)
