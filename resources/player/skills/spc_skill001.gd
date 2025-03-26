extends SpecialSkill

@export var invoke : PackedScene 

func on_ready(owner: Player) -> void:
	owner.animator.get_animation_library("skills_anim").add_animation(skill_id,animation)
	owner.animator.animation_finished.connect(_on_animation_finished)

func start(owner : Player) -> void:
	owner.skill_caster.spc_action_selected_skill()


func _on_animation_finished(anim_name : String) ->void:
	if anim_name == "skills_anim/"+skill_id:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state.state_machine.change_state("RunningState")
		else:
			state.state_machine.change_state("IdleState")
