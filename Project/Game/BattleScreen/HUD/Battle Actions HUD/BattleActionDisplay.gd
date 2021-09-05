extends Control


export(GlobalEnums.BattleActions) var battle_action
export(GlobalEnums.EntityTypes) var entity_type 

export var amount_label = NodePath()
export var battle_action_icon_controller = NodePath()
onready var _amount_label: Label = get_node(amount_label)
onready var _battle_action_icon_controller = get_node(battle_action_icon_controller)

var total_value: int = 0

func _ready() -> void:
	GlobalEvents.connect("entity_battle_action_values_changed", self, "_on_entity_battle_action_values_changed")

func can_drop_data(_position, data):
	return data is Dictionary and data.has("value")

func drop_data(_position, data):
	total_value += data.value
	# _amount_label.text = str(total_value)
#	if total_value > 0:
	_battle_action_icon_controller.set_icon(true)
	data.data_dropped = true
	GlobalEvents.emit_signal("battle_action_display_received_dice_value", data.value, battle_action, entity_type)
#	emit_signal("value_added_to_skill", self, data.value, skill_type, entity_type)

func _on_entity_battle_action_values_changed(entity, battle_action_values):
	if entity == entity_type:
		for key in battle_action_values.keys():
			if key == battle_action:

				_amount_label.text = str(battle_action_values.get(key))

#func on_skill_values_cleared():
#	_amount_label.text = str(0)
#	_skill_stats_icon_controller.set_icon(false)
