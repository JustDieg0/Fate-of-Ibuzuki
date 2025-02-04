extends Area2D

@export var speed:float = 3

var is_facing_right = true
var is_destroying = false

func _ready() -> void:
	$Timer.start()

func _physics_process(delta: float) -> void:
	var pos = 0
	if is_facing_right:
		pos = -1
		scale.x = -1
	else:
		pos = 1
	if not is_destroying:
		position.x += pos*speed

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var direccion : float =  0
		if not is_facing_right:
			direccion = 1
		else:
			direccion = -1
		destroy()
		body.take_damage(direccion,10)


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroy":
		queue_free()

func _on_timer_timeout() -> void:
	if not is_destroying:
		destroy()

func destroy():
	$AnimationPlayer.play("destroy")
	$CollisionShape2D.disabled
	is_destroying = true
