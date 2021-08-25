class_name EntityBaseClass
extends Node

onready var _entity_battle_actions: EntityBattleActions = EntityBattleActions.new()

func _ready() -> void:
	_entity_battle_actions.attacking = 10
	print(_entity_battle_actions)
	
