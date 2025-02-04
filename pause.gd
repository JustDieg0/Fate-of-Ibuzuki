extends CanvasLayer

@onready var lblLeaf = $PowerUpContainer/LeafContainer/HBoxContainer/Label
@onready var lblFire = $PowerUpContainer/FireContainer/HBoxContainer/Label

var isPressed = false

func _ready() -> void:
	$ColorRect.visible = false
	$btnPlay.visible = false
	$btnMenu.visible = false
	$btnRestart.visible = false
	$PowerUpContainer.visible = false
	$Label.visible = false
	Global.menu_pausa = self
	actualizaInterfazFire()
	actualizaInterfazLeaf()

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		alternarPausa()

func alternarPausa():
	get_tree().paused = not get_tree().paused
	$ColorRect.visible = not $ColorRect.visible
	$btnPlay.visible = not $btnPlay.visible
	$btnMenu.visible = not $btnMenu.visible
	$btnRestart.visible = not $btnRestart.visible
	$PowerUpContainer.visible = not $PowerUpContainer.visible
	$Label.visible = not $Label.visible


func _on_btn_play_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		alternarPausa()
		isPressed = false

func actualizaInterfazLeaf():
	lblLeaf.text = str(Global.leaf)

func actualizaInterfazFire():
	lblFire.text = str(Global.fire)


func _on_btn_restart_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		alternarPausa()
		isPressed = false
		get_tree().reload_current_scene()


func _on_btn_menu_pressed() -> void:
	if not isPressed:
		on_button_pressed()
		await $sound_button_pressed.finished
		isPressed = false
		get_tree().change_scene_to_file("res://menu_principal.tscn")

func on_button_pressed():
	isPressed = true
	$sound_button_pressed.play()

func _on_btn_play_mouse_entered() -> void:
	$sound_button_selected.play()



func _on_btn_restart_mouse_entered() -> void:
	$sound_button_selected.play()


func _on_btn_menu_mouse_entered() -> void:
	$sound_button_selected.play()
