extends Node2D

export var icon_sprite = NodePath()
export var sprite_tween = NodePath()

onready var _icon_sprite: Sprite = get_node(icon_sprite)
onready var _sprite_tween:Tween = get_node(sprite_tween)

signal icon_tween_completed

func move_dice_to_skill(_dice_icon, _start_pos, _target_pos):
	_icon_sprite.texture = _dice_icon
	var _err = _sprite_tween.interpolate_property(_icon_sprite, "position", _start_pos, _target_pos, 2, Tween.TRANS_SINE, Tween.EASE_IN)
	_err = _sprite_tween.start()

func _on_SpriteTween_tween_all_completed():
	_icon_sprite.texture = null
	emit_signal("icon_tween_completed")
