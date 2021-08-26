class_name EntityBaseClass
extends Node2D

export(GlobalEnums.EntityTypes) var entity_type

onready var _entity_battle_actions: EntityBattleActions = EntityBattleActions.new()
onready var _entity_health: EntityHealth = EntityHealth.new()

export(int) var start_health 
export(int) var dice_amount

func _ready() -> void:
	_entity_health.entity_type = entity_type
	_entity_health.set_start_health(start_health)

