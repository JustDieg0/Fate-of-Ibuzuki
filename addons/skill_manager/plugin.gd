@tool
extends EditorPlugin

var pkg_skill : Script
var skill : Script
var sk_caster : Script

func _enter_tree():
	pkg_skill = preload("res://addons/skill_manager/packed_skill.gd")
	skill = preload("res://addons/skill_manager/skill.gd")
	sk_caster = preload("res://addons/skill_manager/skill_caster.gd")
	
	add_autoload_singleton("SkillManager", get_plugin_path() + "/skill_manager.gd")
	add_custom_type("PackagedSkill","Resource",pkg_skill,preload("res://addons/skill_manager/assets/icon_group_skill.svg"))
	add_custom_type("Skill","Resource",skill,preload("res://addons/skill_manager/assets/icon_skill.svg"))
	add_custom_type("SkillCaster","Node",sk_caster,preload("res://addons/skill_manager/assets/icon.svg"))

func _exit_tree():
	remove_autoload_singleton("SkillManager")
	remove_custom_type("PackagedSkill")
	remove_custom_type("Skill")
	remove_custom_type("SkillCaster")

func get_plugin_path() -> String:
	return get_script().resource_path.get_base_dir()
