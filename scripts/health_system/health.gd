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

func on_take_damage(damage: float) ->void:
	pass
