extends BoxContainer

enum SkillTypes {HEALTH, BLOCK, ATTACK}

export(SkillTypes) var skill_type
export var amount_label = NodePath()
onready var _amount_label = get_node(amount_label)

var total_value = 0

signal value_added_to_skill(value, skill)

func can_drop_data(_position, data):
    return data is Dictionary and data.has("value")

func drop_data(_position, data):
    total_value += data.value
    _amount_label.text = str(total_value)
    emit_signal("value_added_to_skill", total_value, skill_type)