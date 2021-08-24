extends TextureRect

onready var _icon_active: TextureRect = get_node("IconActive")
onready var _icon_inactive: TextureRect = get_node("IconInActive")
onready var _icon_mouse_over: TextureRect = get_node("IconMouseOver")

var is_activated: bool = false

func set_icon(set_activated) -> void:
	is_activated = set_activated
	_icon_active.visible = is_activated
	_icon_inactive.visible = !is_activated
	_icon_mouse_over.visible = false

func _on_iconBackground_mouse_entered() -> void:
	if is_activated:
		return
	else:
		_icon_mouse_over.visible = true

func _on_iconBackground_mouse_exited():
	_icon_mouse_over.visible = false
