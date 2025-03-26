class_name Skill
extends Resource
@export var skill_id : String = "ID"
@export var skill_name : String = "Skill"
@export var description : String = "Description Text"
@export var icon : Texture2D
@export var animation: Animation
@export var cooldown : float = 10

var state : PlayerStateBase:
	set(val):
		state = val
	get:
		return state

func on_ready(owner: Player) -> void:
	owner.animator.get_animation_library("skills_anim").add_animation(skill_id,animation)

func on_exit(owner: Player) -> void:
	owner.animator.get_animation_library("skills_anim").remove_animation(skill_id)

func start(owner: Player) -> void:
	pass

func end(owner: Player) -> void:
	pass

func action_skill(owner: Player) -> void:
	owner.animator.play("skills_anim/"+skill_id)
