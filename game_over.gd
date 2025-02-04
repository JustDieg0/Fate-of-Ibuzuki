extends CanvasLayer

var isPressed = false

func _ready() -> void:
	$ColorRect.visible = false
	$VolverMenu.visible = false
	$Reiniciar.visible = false
	$Label.visible = false
	Global.menu_gameover = self


func _on_reiniciar_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		get_tree().paused = false
		get_tree().reload_current_scene()

func _on_volver_menu_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		get_tree().paused = false
		get_tree().change_scene_to_file("res://menu_principal.tscn")

func player_lost():
	get_tree().paused = true
	$ColorRect.visible = true
	$VolverMenu.visible = true
	$Reiniciar.visible = true
	$Label.visible = true

func on_button_pressed():
	isPressed = true
	$sound_button_pressed.play()

func _on_volver_menu_mouse_entered() -> void:
	$sound_button_selected.play()


func _on_reiniciar_mouse_entered() -> void:
	$sound_button_selected.play()
