extends Node2D

export var dice_controller = NodePath()
export var roll_button = NodePath()
export var dices_display = NodePath()
onready var _dice_controller = get_node(dice_controller)
onready var _roll_button = get_node(roll_button)
onready var _dices_display = get_node(dices_display)

var rolled_dices = []

func _ready():
	if _roll_button:
		_roll_button.connect("button_down", self, "on_roll_button_down")

func on_roll_button_down():
	if _dice_controller:
		rolled_dices = _dice_controller.roll_dices(3)
		if _dices_display:
			_dices_display.display_dice_roll(rolled_dices)
