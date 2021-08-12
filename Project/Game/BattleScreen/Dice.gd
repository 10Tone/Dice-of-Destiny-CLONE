extends TextureRect

var data = {}

func _ready():
	texture = null

func display_dice(dice):
	data.value = dice.value
	data.icon = dice.icon
	texture = data.icon

func get_drag_data(_position):
	var drag_preview = TextureRect.new()
	drag_preview.texture = texture
	set_drag_preview(drag_preview)
	print("getting drag data")
	texture = null

	return data

func clear_dice():
	texture = null
	data = {}

