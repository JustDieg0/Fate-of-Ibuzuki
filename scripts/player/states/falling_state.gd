extends PlayerStateGravityBase

func start() -> void:
	player.animator.play("fall")

func on_physics_process(delta) -> void:
	move_x()
	flip()
	
	if player.velocity.y >= 0 and player.is_on_floor():
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state_machine.change_state("RunningState")
		else:
			state_machine.change_state("IdleState")
	
	handle_gravity(delta)
	player.move_and_slide()

func move_x():
	var input_axis = Input.get_axis("move_left","move_right")
	controlled_node.velocity.x = input_axis * player.move_speed

func flip():
	if (player.is_facing_right and player.velocity.x > 0) or (not player.is_facing_right and player.velocity.x < 0):
		player.scale.x *= -1
		player.is_facing_right = not player.is_facing_right
