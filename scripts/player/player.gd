@icon("res://script_icon/player_icon.svg")
class_name Player
extends CharacterBody2D

@export var move_speed:float = 200
@export var jump_speed:float = 400
@export var animator: AnimationPlayer
@export var skill_caster: SkillCaster
var is_facing_right = true
