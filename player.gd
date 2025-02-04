extends CharacterBody2D
class_name Player

@export var move_speed:float = 200
@export var jump_speed:float = 400
@export var box_obj: PackedScene
@export var fireball: PackedScene
@export var atk_vfx: PackedScene
@onready var animated_sprite: AnimationPlayer = $AnimationPlayer
@onready var health_bar : TextureProgressBar = $PlayerGUI/TextureProgressBar
var is_facing_right = true
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var anim_pos = 1
var flaganimationJump = false
var flaganimationFall = false
var isAttacking = false
var isHurt = false
var current_anim_pos

func _ready() -> void:
	Global.player = self
	$Sprite2D/BasicHit/CollisionShape2D.disabled = true
	actualizar_vida()
	actualizar_vida_max()

func _physics_process(delta: float) -> void:
	jump(delta)
	move_x()
	flip()
	await_animations()
	update_animations()
	is_hurt_in_floor()
	move_and_slide()
	current_anim_pos = animated_sprite.current_animation_position

func await_animations():
	if Input.is_action_just_pressed("eAtk") and is_on_floor() and not isAttacking and not isHurt:
		animated_sprite.play("basicAtk")
		isAttacking = true
		$cd_atk_vfx.start()
		await animated_sprite.animation_finished
		isAttacking = false
	if Input.is_action_just_pressed("qAtk") and is_on_floor() and not isAttacking and not isHurt:
		animated_sprite.play("elementalBurst")
		isAttacking = true
		await animated_sprite.animation_finished
		isAttacking = false
	if Input.is_action_just_pressed("distanceAtk") and is_on_floor() and not isAttacking and not isHurt and Global.fire >=5:
		animated_sprite.play("distanceAtk")
		isAttacking = true
		$cd_fuego.start()
		await animated_sprite.animation_finished
		isAttacking = false

func update_animations():
	if isAttacking : return
	if isHurt : return
	if not is_on_floor():
		if velocity.y < 0 and not flaganimationJump:
			animated_sprite.play("jump")
			flaganimationJump = true
		else:
			if not flaganimationFall:
				animated_sprite.play("fall")
				flaganimationFall = true
		return
	flaganimationFall = false
	flaganimationJump = false
	if velocity.x:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")

func jump(delta: float):
	if Input.is_action_just_pressed("jump") and is_on_floor() and not isAttacking and not isHurt:
		velocity.y = -jump_speed
	
	velocity.y += gravity * delta

func move_x():
	if isAttacking: 
		velocity.x = 0
		return
	elif isHurt:
		return
	var input_axis = Input.get_axis("move_left","move_right")
	velocity.x = input_axis * move_speed

func flip():
	if isAttacking: return
	if isHurt: return
	if (is_facing_right and velocity.x > 0) or (not is_facing_right and velocity.x < 0):
		scale.x *= -1
		is_facing_right = not is_facing_right

func _on_basic_hit_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		var direccion : float =  0
		if not is_facing_right:
			direccion = 1
		else:
			direccion = -1
		body.take_damage(direccion,10)

func take_damage(direccion : float, daño: float):
	isHurt = true
	isAttacking = false
	var vida = health_bar.value - daño
	if(vida <= 0):
		health_bar.value = 0
		Global.dead+=1
		velocity = Vector2(-400 * direccion ,-200)
		animated_sprite.play("hurt")
		get_node("../GameOver").player_lost()
	else:
		health_bar.value = vida
	animated_sprite.play("hurt")
	$hit.play()
	velocity = Vector2(-400 * direccion ,-200)
	
func is_hurt_in_floor():
	if is_on_floor() and isHurt and velocity.y >= 0:
		isHurt = false

func actualizar_vida():
	health_bar.value = Global.player_health

func actualizar_vida_max():
	health_bar.max_value = Global.max_player_health

func mostrar_obj(obj: String):
	var pathTexture = "res://assets/sprites/obj/"
	if obj == "leaf":
		if box_obj:
			var instancia = box_obj.instantiate()
			$PlayerGUI.add_child(instancia)
			instancia.get_node("Label").text = str(Global.leaf)+"/5"
			instancia.get_node("TextureRect").texture = load(pathTexture+"leafobj.png")
	if obj == "fire":
		if box_obj:
			var instancia = box_obj.instantiate()
			$PlayerGUI.add_child(instancia)
			instancia.get_node("Label").text = str(Global.fire)+"/5"
			instancia.get_node("TextureRect").texture = load(pathTexture+"fireobj.png")


func _on_cd_fuego_timeout() -> void:
	if fireball:
		if animated_sprite.current_animation == "distanceAtk" and isAttacking:
			var instancia = fireball.instantiate()
			get_tree().root.add_child(instancia)
			instancia.is_facing_right = is_facing_right
			instancia.global_position = $Marker2D.global_position


func _on_cd_atk_vfx_timeout() -> void:
	if atk_vfx:
		if animated_sprite.current_animation == "basicAtk" and isAttacking:
			var instancia = atk_vfx.instantiate()
			get_tree().root.add_child(instancia)
			if not is_facing_right:
				instancia.scale.x = -1
			instancia.global_position = $Sprite2D/BasicHit/Marker2D.global_position
