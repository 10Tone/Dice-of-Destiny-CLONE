extends Control

onready var _dices_hbox_container: Node = $HBoxContainer

func display_dice_roll(dices: Array) -> void:
	if !_dices_hbox_container: return
	
	for i in range(dices.size()):
		_dices_hbox_container.get_child(i).display_dice(dices[i])

func clear_dices() -> void:
	if !_dices_hbox_container: return
	for i in range(_dices_hbox_container.get_children().size()):
		_dices_hbox_container.get_child(i).clear_dice()
