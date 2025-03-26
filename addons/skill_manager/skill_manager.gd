extends Node

func _ready() -> void:
	if not Engine.has_singleton("SkillManager"):
		Engine.register_singleton("SkillManager", self)

# Guarda los IDs de las habilidades equipadas
var selected_skills: Array[String] = [] :
	set(val):
		selected_skills = val
	get:
		return selected_skills


func equip_skill(skill_id: String):
	if skill_id in selected_skills:
		print("Ya tienes esta habilidad equipada.")
		return
	if selected_skills.size() < 4:
		selected_skills.append(skill_id)
		print("Habilidad equipada:", skill_id)
	else:
		print("No puedes equipar más de 4 habilidades.")

func get_selected_skills():
	return selected_skills

func reset_skills():
	selected_skills.clear()
