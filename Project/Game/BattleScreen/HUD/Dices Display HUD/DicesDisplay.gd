extends Control

onready var _dices_hbox_container: Node = $HBoxContainer

func _ready() -> void:
	GlobalEvents.connect("dices_rolled", self, "on_dices_rolled")

func display_dice_roll(dices: Array) -> void:
	if !_dices_hbox_container: return
	
	for i in range(dices.size()):
		_dices_hbox_container.get_child(i).display_dice(dices[i])

func clear_dices() -> void:
	if !_dices_hbox_container: return
	for i in range(_dices_hbox_container.get_children().size()):
		_dices_hbox_container.get_child(i).clear_dice()

func on_dices_rolled(dices: Array) -> void:
	display_dice_roll(dices)
