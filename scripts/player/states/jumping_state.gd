extends PlayerStateGravityBase

func start() -> void:
	player.animator.play("jump")
	player.velocity.y = -player.jump_speed

func on_physics_process(delta) -> void:
	move_x()
	flip()
	jump(delta)
	
	handle_gravity(delta)
	player.move_and_slide()

func move_x():
	var input_axis = Input.get_axis("move_left","move_right")
	controlled_node.velocity.x = input_axis * player.move_speed

func flip():
	if (player.is_facing_right and player.velocity.x > 0) or (not player.is_facing_right and player.velocity.x < 0):
		player.scale.x *= -1
		player.is_facing_right = not player.is_facing_right

func jump(delta) -> void:
	if player.is_on_floor() and player.velocity.y >= 0:
		player.velocity.y = player.move_speed
	elif player.velocity.y > 0: state_machine.change_state("FallingState")
