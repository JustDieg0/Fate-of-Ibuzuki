extends CanvasLayer

var isPressed = false

func _ready() -> void:
	get_tree().paused = false

func _on_jugar_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		isPressed = false
		get_tree().change_scene_to_file("res://level_1.tscn")


func _on_opciones_pressed() -> void:
	on_button_pressed()
	isPressed = false
	pass # Replace with function body.


func _on_salir_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		isPressed = false
		get_tree().quit()

func on_button_pressed():
	isPressed = true
	$sound_button_pressed.play()

func _on_jugar_mouse_entered() -> void:
	$sound_button_selected.play()


func _on_opciones_mouse_entered() -> void:
	$sound_button_selected.play()


func _on_salir_mouse_entered() -> void:
	$sound_button_selected.play()
