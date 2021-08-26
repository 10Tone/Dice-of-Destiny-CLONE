class_name EntityHealth
extends Node

var entity_type
var health: int 
var start_health: int setget set_start_health
	
func set_start_health(value) -> void:
	start_health = value
	health = start_health
	GlobalEvents.emit_signal("entity_health_value_changed", entity_type, health)

func add_health(amount: int) -> void:
	health += amount
	if health > start_health:
		health = start_health
	GlobalEvents.emit_signal("entity_health_value_changed", entity_type ,health)

func take_health(amount: int) -> void:
	amount -= self.block_skill
	if amount < 0:
		return
	health -= amount
	if health < 0:
		health = 0
		GlobalEvents.emit_signal("entity_died", entity_type)
	GlobalEvents.emit_signal("entity_health_value_changed", entity_type, health)
