extends Control

enum EntityTypes {PLAYER, ENEMY}

export var player_health_label = NodePath()
export var enemy_health_label = NodePath()
export var player_progress_bar = NodePath()
export var enemey_progress_bar = NodePath()

onready var _player_health_label = get_node(player_health_label)
onready var _enemy_health_label = get_node(enemy_health_label)
onready var _player_progress_bar = get_node(player_progress_bar)
onready var _enemy_progress_bar = get_node(enemey_progress_bar)

func on_entity_health_value_changed(entity_type, value):
	match entity_type:
		EntityTypes.PLAYER:
			if _player_health_label:
				_player_health_label.text = str(value)
				# print("health changed")
			if _player_progress_bar:
				_player_progress_bar.value = value
		EntityTypes.ENEMY:
			if _enemy_health_label:
				_enemy_health_label.text = str(value)
	
