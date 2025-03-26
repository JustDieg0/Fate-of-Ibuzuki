extends PlayerStateGravityBase

var skill: UltimateSkill = null

func start() -> void:
	skill = player.skill_caster.get_selected_ult_skill()
	if skill:
		skill.state = self
		player.skill_caster.ult_start_selected_skill()
	else:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state_machine.change_state("RunningState")
		else:
			state_machine.change_state("IdleState")

func end() -> void:
	player.skill_caster.ult_end_selected_skill()

func on_process(delta:float) -> void:
	if skill and skill.has_method("on_process"):
		skill.on_process(delta)
		
func on_physics_process(delta:float) -> void:
	if skill and skill.has_method("on_physics_process"):
		skill.on_physics_process(delta)
		
func on_input(event:InputEvent) -> void:
	if skill and skill.has_method("on_input"):
		skill.on_input(event)
		
func on_unhandled_input(event:InputEvent) -> void:
	if skill and skill.has_method("on_unhandled_input"):
		skill.on_unhandled_input(event)
		
func on_unhandled_key_input(event:InputEvent) -> void:
	if skill and skill.has_method("on_unhandled_key_input"):
		skill.on_unhandled_key_input(event)
