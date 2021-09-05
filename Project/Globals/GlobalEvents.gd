extends Node
class_name Events

signal reload_button_pressed

# entity signals
signal entity_state_changed(entity_type, entity_state)
signal entity_battle_action_values_changed(entity_type, battle_action_values)
signal entity_health_value_changed(entity_type, value)
signal entity_died(entity_type)

#battle action display signals
signal battle_action_display_received_dice_value(value, battle_action, entity_type)

#dices rolled signal
signal dices_rolled(dices)

signal new_turn_started()
