extends CharacterBody2D

@export var move_speed:float = 40
@export var jump_speed:float = 400
@export var healt:float = 30
@export var level: Node
@export var lblDaño: PackedScene
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isHurt = false
var isDie = false
var is_facing_left = true

func _ready() -> void:
	velocity.x = move_speed
	add_to_group("Enemy")

func _physics_process(delta: float) -> void:
	velocity.y += gravity * delta
	
	if not isHurt:
		animated_sprite.play("idle")
		choca_muro()
		flip()
	is_hurt_in_floor()
	move_and_slide()

func choca_muro():
	if is_on_wall():
		if !is_facing_left:
			velocity.x = move_speed
		else:
			velocity.x = -move_speed

func flip():
	if (is_facing_left and velocity.x < 0) or (not is_facing_left and velocity.x > 0):
		scale.x *= -1
		is_facing_left = not is_facing_left
	

func take_damage(direccion : float, daño : float):
	isHurt = true
	if level:
		if lblDaño:
			var instancia = lblDaño.instantiate()
			instancia.position = position
			instancia.text = str(daño)
			level.add_child(instancia)
	var vida = healt - daño
	if vida <= 0:
		isDie = true
		$Area2D.disable_mode = true
		animated_sprite.play("die")
		velocity = Vector2(200 * direccion ,-200)
		await  animated_sprite.animation_finished
		queue_free()
		return
	else:
		healt = vida
	animated_sprite.play("hurt")
	velocity = Vector2(200 * direccion ,-200)
	
func is_hurt_in_floor():
	if is_on_floor() and isHurt and velocity.y > 0 and not isDie:
		isHurt = false
		var aux = velocity.x / abs(velocity.x)
		if aux == 0 and is_facing_left:
			aux = -1
		else:
			aux = 1
		velocity.x = move_speed * aux
	elif is_on_floor() and velocity.y > 0 and isDie:
		velocity.y = -velocity.y


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var direccion : float =  0
		if not is_facing_left:
			direccion = 1
		else:
			direccion = -1
		body.take_damage(direccion,10)
