extends Control

enum EntityTypes {PLAYER, ENEMY}

export var player_health_label = NodePath()
export var enemy_health_label = NodePath()

onready var _player_health_label = get_node(player_health_label)
onready var _enemy_health_label = get_node(enemy_health_label)

func on_entity_health_value_changed(entity_type, value):
    match entity_type:
        EntityTypes.PLAYER:
            if _player_health_label:
                _player_health_label.text = str(value)
                print("health changed")
        EntityTypes.ENEMY:
            if _enemy_health_label:
                _enemy_health_label.text = str(value)
    
