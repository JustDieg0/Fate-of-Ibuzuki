class_name  Health
extends Node

#vida base del jugador o enemigo
@export var base_health : float = 100

#resistencias elementales
@export var normal_res : float = 0
@export var fire_res: float = 0
@export var leaf_res: float = 0
@export var thunder_res: float = 0
@export var water_res: float = 0
@export var wind_res: float = 0

func convert_damage(dmg: float, type: String) ->float:
	var final_dmg = dmg
	match type:
		"normal": final_dmg*(1+normal_res)
		"fire": final_dmg*(1+fire_res)
		"leaf": final_dmg*(1+leaf_res)
		"thunder": final_dmg*(1+thunder_res)
		"water": final_dmg*(1+water_res)
		"wind": final_dmg*(1+wind_res)
	return final_dmg

func on_take_damage(damage : Damage) -> void:
	#espacio reservado para reacciones elementales
	base_health =- convert_damage(damage.dmg, damage.dmg_type)
