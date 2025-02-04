extends Node

var leaf := 0 :
	set(val):
		leaf = val
		if menu_pausa != null:
			menu_pausa.actualizaInterfazLeaf()
		if player != null:
			player.mostrar_obj("leaf")
	get:
		return leaf

var fire := 0 :
	set(val):
		fire = val
		if menu_pausa != null:
			menu_pausa.actualizaInterfazFire()
		if player != null:
			player.mostrar_obj("fire")
	get:
		return fire

var max_player_health := 50 :
	set(val):
		max_player_health = val
		if player != null:
			player.actualizar_vida_max()
	get:
		return max_player_health


var player_health := 50 :
	set(val):
		player_health = val
		if player != null:
			player.actualizar_vida()
	get:
		return player_health

var dead := 0 :
	set (val):
		dead = val
		if menu_gameover != null:
			pass
			#menu_gameover.player_lost()
	get:
		return dead

var player
var menu_pausa
var menu_gameover

func reconocer_obj(obj: String):
	match obj:
		"leaf": leaf += 1
		"fire": fire += 1
		_: return
