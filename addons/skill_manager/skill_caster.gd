extends Node
class_name SkillCaster

var skills: Array[PackedSkill]
var selected_skill: int = 0
var timers: Array[PackedTimer]

func _ready() -> void:
	load_selected_skills()

func load_selected_skills():
	on_clear()
	var i = 1
	for pkg_skill_id in SkillManager.selected_skills:
		var pkg_skill : PackedSkill = get_pkg_skill_by_id(pkg_skill_id)
		if pkg_skill:
			skills.append(pkg_skill)
			pkg_skill.spc_skill.on_ready(self.owner)
			pkg_skill.ult_skill.on_ready(self.owner)
			var pkg_timer = PackedTimer.new()
			pkg_timer.spc_timer.wait_time = pkg_skill.spc_skill.cooldown
			pkg_timer.ult_timer.wait_time = pkg_skill.ult_skill.cooldown
			timers.append(pkg_timer)
			i += 1

func get_pkg_skill_by_id(skill_id: String) -> PackedSkill:
	var skill_library = {
		"pkg_001" : preload("res://resources/player/skills/pkg_skill001.tres"),
		"heal" : 'preload("a")'
	}
	return skill_library.get(skill_id,null)

func on_clear() -> void:
	var i = 1
	for pkg_skill in skills:
		if pkg_skill:
			pkg_skill.spc_skill.on_exit(self.owner)
			pkg_skill.ult_skill.on_exit(self.owner)
			i += 1
	skills.clear()
	timers.clear()

func equip_one_skill(skill_id: String) -> void:
	if skills.size() < 4:
		var pkg_skill : PackedSkill = get_pkg_skill_by_id(skill_id)
		if pkg_skill:
			print("se añadio "+str(pkg_skill.pkg_skill_id))
			skills.append(pkg_skill)
			var i = skills.size()
			pkg_skill.spc_skill.on_ready(self.owner)
			pkg_skill.ult_skill.on_ready(self.owner)
			print((self.owner as Player).animator.get_animation_list())
			var pkg_timer = PackedTimer.new()
			pkg_timer.spc_timer.wait_time = pkg_skill.spc_skill.cooldown
			pkg_timer.ult_timer.wait_time = pkg_skill.ult_skill.cooldown
			timers.append(pkg_timer)

func on_equip_skills(pkg_skills: Array[String]) -> void:
	on_clear()
	var i = 1
	for pkg_skill_id in pkg_skills:
		var pkg_skill : PackedSkill = get_pkg_skill_by_id(pkg_skill_id)
		if pkg_skill:
			skills.append(pkg_skill)
			pkg_skill.spc_skill.on_ready(self.owner)
			pkg_skill.ult_skill.on_ready(self.owner)
			var pkg_timer = PackedTimer.new()
			pkg_timer.spc_timer.wait_time = pkg_skill.spc_skill.cooldown
			pkg_timer.ult_timer.wait_time = pkg_skill.ult_skill.cooldown
			timers.append(pkg_timer)
			i += 1

func spc_action_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].spc_skill.action_skill(self.owner)
	timers[selected_skill].spc_timer.start()

func spc_start_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].spc_skill.start(self.owner)

func spc_end_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].spc_skill.end(self.owner)

func ult_action_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].ult_skill.action_skill(self.owner)
	timers[selected_skill].spc_timer.start()

func ult_start_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].ult_skill.start(self.owner)

func ult_end_selected_skill():
	if skills.is_empty():
		return
	skills[selected_skill].ult_skill.end(self.owner)

func get_selected_spc_skill() -> SpecialSkill:
	if skills:
		return skills[selected_skill].spc_skill
	else:
		return null

func get_selected_ult_skill() -> UltimateSkill:
	if skills:
		return skills[selected_skill].ult_skill
	else:
		return null

func change_skill(index: int):
	if index >= 0 and index < skills.size():
		selected_skill = index
