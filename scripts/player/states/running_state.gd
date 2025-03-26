extends PlayerStateGravityBase

func start() -> void:
	player.animator.play("run")

func on_physics_process(delta) -> void:
	move_x()
	flip()
	
	handle_gravity(delta)
	player.move_and_slide()

func move_x():
	var input_axis = Input.get_axis("move_left","move_right")
	controlled_node.velocity.x = input_axis * player.move_speed

func flip():
	if (player.is_facing_right and player.velocity.x > 0) or (not player.is_facing_right and player.velocity.x < 0):
		player.scale.x *= -1
		player.is_facing_right = not player.is_facing_right

func on_input(_event):
	if not Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		state_machine.change_state("IdleState")
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state("JumpingState")
	elif Input.is_action_just_pressed("eAtk"):
		state_machine.change_state("SpecialAtkState")
	elif Input.is_action_just_pressed("qAtk"):
		state_machine.change_state("UltimateAtkState")
