extends TextureRect

var data = null

func _ready():
	texture = null

func display_dice(dice: DiceResource) -> void:
	data = {}
	data.value = dice.value
	data.icon = dice.icon
	data.data_dropped = false
	texture = data.icon
	# print(data.value)

func get_drag_data(_position: Vector2) -> Dictionary:
	var parent_preview = Control.new()
	var drag_preview = TextureRect.new()
	drag_preview.texture = texture
	parent_preview.add_child(drag_preview)
	drag_preview.rect_size = texture.get_size()
	drag_preview.rect_position = -0.5 * drag_preview.rect_size
	set_drag_preview(parent_preview)
	# print("getting drag data")
	texture = null

	return data

func clear_dice() -> void:
	texture = null
	data = null

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_released("ui_left_mouse_button") and data is Dictionary:
		if data.icon and !data.data_dropped:
			texture = data.icon

