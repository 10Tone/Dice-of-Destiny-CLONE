class_name EntityBattleActions
extends Node

enum BattleActions {HEALING, BLOCKING, ATTACKING}
enum EntityTypes {PLAYER, ENEMY}

var entity_type

var activate_multiplier: bool = false setget set_activate_multiplier
var healing:int = 0 setget set_healing, get_healing
var blocking:int = 0 setget set_blocking, get_blocking
var attacking:int = 0 setget set_attacking, get_attacking

var battle_action_values: Dictionary = {BattleActions.HEALING: 0, BattleActions.BLOCKING: 0, BattleActions.ATTACKING: 0}

#signal entity_battle_action_values_changed
#signal battle_action_values_cleared

func set_healing(amount: int) -> void:
	if activate_multiplier:
		healing += amount
		healing *= 2
	else:
		if amount == 0:
			healing = 0
		else:
			healing += amount
	battle_action_values[BattleActions.HEALING] = healing
	GlobalEvents.emit_signal("entity_battle_action_values_changed",entity_type, battle_action_values)
	
	
func get_healing() -> int:
	var return_healing_value = healing
	healing = 0
	return return_healing_value


func set_blocking(amount: int) -> void:
	if activate_multiplier:
		blocking += amount
		blocking *= 2
	else:
		if amount == 0:
			blocking = 0
		else:
			blocking += amount
	battle_action_values[BattleActions.BLOCKING] = blocking
	GlobalEvents.emit_signal("entity_battle_action_values_changed",entity_type, battle_action_values)
	
	
func get_blocking() -> int:
	return blocking


func set_attacking(amount: int) -> void:
	if activate_multiplier:
		attacking += amount
		attacking *= 2
	else:
		if amount == 0:
			attacking = 0
		else:
			attacking += amount
	battle_action_values[BattleActions.ATTACKING] = attacking
	GlobalEvents.emit_signal("entity_battle_action_values_changed",entity_type, battle_action_values)
	
	
func get_attacking() -> int:
	return attacking


func set_activate_multiplier(_activate_multiplier: bool) -> void:
	activate_multiplier = _activate_multiplier
	self.healing = 0
	self.blocking = 0
	self.attacking = 0


func clear_battle_action_values() -> void:
	self.healing = 0
	self.blocking = 0
	self.attacking = 0
#	battle_action_values[BattleActions.HEALING] = 0
#	battle_action_values[BattleActions.BLOCKING] = 0
#	battle_action_values[BattleActions.ATTACKING] = 0
	activate_multiplier = false
#	emit_signal("battle_action_values_cleared")
