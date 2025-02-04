extends Area2D

@onready var timer = $Cdanimation
@onready var aniSprite = $AnimatedSprite2D
var contar: float = 0
var cdFin: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.play("idle")
	cdFin = cdFinish()


func _on_animated_sprite_2d_animation_finished() -> void:
	print("contar: " +str(contar)+ "cdFin: " +str(cdFin))
	if aniSprite.animation == "idle":
		contar += 1
		if contar >= cdFin:
			aniSprite.play("idle2")
	else:
		contar = 0
		cdFin = cdFinish()
		aniSprite.play("idle")



func cdFinish():
	var random_float = randi_range(3.0, 5.0)
	return random_float


func _on_animated_sprite_2d_frame_changed() -> void:
	if aniSprite.animation == "idle" and aniSprite.frame == aniSprite.sprite_frames.get_frame_count("idle") - 1:
		contar += 1
		if contar == cdFin:
			aniSprite.play("idle2")
			contar = 0
			cdFin = cdFinish()
	if aniSprite.animation == "idle2" and aniSprite.frame == aniSprite.sprite_frames.get_frame_count("idle2") - 1:
		aniSprite.play("idle")
