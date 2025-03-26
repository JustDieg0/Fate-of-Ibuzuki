extends PlayerStateGravityBase

func start() -> void:
	player.animator.play("idle")

func on_physics_process(delta):
	player.velocity.x = 0
	
	handle_gravity(delta)
	
	player.move_and_slide()

func on_input(_event) ->void:
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_state("RunningState")
	elif Input.is_action_just_pressed("jump"):
		state_machine.change_state("JumpingState")
	elif Input.is_action_just_pressed("eAtk"):
		state_machine.change_state("SpecialAtkState")
	elif Input.is_action_just_pressed("qAtk"):
		state_machine.change_state("UltimateAtkState")
