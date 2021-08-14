extends VBoxContainer

export var amount_label = NodePath()
onready var _amount_label = get_node(amount_label)

var total_value = 0
var activated = false

signal skill_multiplier_activated

func can_drop_data(_position, data):
	return data is Dictionary and data.has("value")

func drop_data(_position, data):
	total_value += data.value
	_amount_label.text = str(total_value)

	if total_value == 7 and !activated:
		activated = true
		emit_signal("skill_multiplier_activated")

func clear_seven_multiplier():
	activated = false
	total_value = 0
	_amount_label.text = str(total_value)