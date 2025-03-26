extends MarginContainer

@onready var label = $MarginContainer/Label

const MAX_WIDTH = 256

var text = ""

func display_text(text_to_display: String, scale: float):
	text = text_to_display
	label.text = text_to_display
	
	await resized
	custom_minimum_size.x = min(size.x,MAX_WIDTH)
	
	if size.x > MAX_WIDTH:
		label.autowrap_mode = TextServer.AUTOWRAP_WORD
		await resized
		await resized
		custom_minimum_size.y = size.y
	global_position.x -= size.x / 2 * scale
	global_position.y -= (size.y +24 )* scale
