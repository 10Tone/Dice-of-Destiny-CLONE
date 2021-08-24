extends VBoxContainer

export var amount_label = NodePath()
onready var _amount_label: Label = get_node(amount_label)

var total_value: int = 0
var is_activated: bool = false

signal skill_multiplier_activated

func can_drop_data(_position: Vector2, data) -> bool:
	return data is Dictionary and data.has("value")
	

func drop_data(_position: Vector2, data) -> void:
	total_value += data.value
	_amount_label.text = str(total_value)

	if total_value == 7 and !is_activated:
		is_activated = true
		emit_signal("skill_multiplier_activated")

func clear_seven_multiplier() -> void:
	is_activated = false
	total_value = 0
	_amount_label.text = str(total_value)
