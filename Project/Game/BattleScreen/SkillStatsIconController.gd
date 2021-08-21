extends TextureRect

onready var _icon_active = get_node("IconActive")
onready var _icon_inactive = get_node("IconInActive")
onready var _icon_mouse_over = get_node("IconMouseOver")

var activated = false

func _ready():
	pass # Replace with function body.

func set_icon(set_activated):
	activated = set_activated
	_icon_active.visible = activated
	_icon_inactive.visible = !activated
	_icon_mouse_over.visible = false


func _on_iconBackground_mouse_entered():
	if activated:
		return
	else:
		_icon_mouse_over.visible = true


func _on_iconBackground_mouse_exited():
	_icon_mouse_over.visible = false
