extends BoxContainer

enum SkillTypes {HEALTH, BLOCK, ATTACK}
enum EntityTypes {PLAYER, ENEMY}

export(SkillTypes) var skill_type
export(EntityTypes) var entity_type 
export var amount_label = NodePath()
export var skill_stats_icon_controller = NodePath()
onready var _amount_label = get_node(amount_label)
onready var _skill_stats_icon_controller = get_node(skill_stats_icon_controller)

var total_value = 0

signal value_added_to_skill(value, skill)

func _init():
	add_to_group("skills")

func can_drop_data(_position, data):
	return data is Dictionary and data.has("value")

func drop_data(_position, data):
	total_value += data.value
	# _amount_label.text = str(total_value)
#	if total_value > 0:
	_skill_stats_icon_controller.set_icon(true)
	data.data_dropped = true
	emit_signal("value_added_to_skill", self, data.value, skill_type, entity_type)

func on_entity_skill_values_changed(entity, skill_values):
	if entity == entity_type:
		for key in skill_values.keys():
			if key == skill_type:
				_amount_label.text = str(skill_values.get(key))

func on_skill_values_cleared():
	_amount_label.text = str(0)
	_skill_stats_icon_controller.set_icon(false)
