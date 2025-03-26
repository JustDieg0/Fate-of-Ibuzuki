extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		(body as Player).skill_caster.equip_one_skill("pkg_001")
