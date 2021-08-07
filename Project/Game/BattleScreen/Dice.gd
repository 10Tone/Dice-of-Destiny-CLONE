extends TextureRect

var data = {}

func display_dice(dice):
	data.value = dice.value
	data.icon = dice.icon
	texture = data.icon

func get_drag_data(_position):
	var drag_preview = TextureRect.new()
	drag_preview.texture = texture
	set_drag_preview(drag_preview)

	texture = null

	return data
