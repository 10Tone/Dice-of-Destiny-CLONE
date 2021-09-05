extends Control

export var player_health_label = NodePath()
export var enemy_health_label = NodePath()
export var player_progress_bar = NodePath()
export var enemey_progress_bar = NodePath()

onready var _player_health_label: Label = get_node(player_health_label)
onready var _enemy_health_label: Label = get_node(enemy_health_label)
onready var _player_progress_bar: TextureProgress = get_node(player_progress_bar)
onready var _enemy_progress_bar: TextureProgress = get_node(enemey_progress_bar)

func _ready() -> void:
	GlobalEvents.connect("entity_health_value_changed", self, "on_entity_health_value_changed")

func on_entity_health_value_changed(entity_type: int, value: int):
	match entity_type:
		GlobalEnums.EntityTypes.PLAYER:
			if _player_health_label:
				_player_health_label.text = str(value)
				# print("health changed")
			if _player_progress_bar:
				print("change progress bar")
				_player_progress_bar.value = value
		GlobalEnums.EntityTypes.ENEMY:
			if _enemy_health_label:
				_enemy_health_label.text = str(value)
				
			if _enemy_progress_bar:
				_enemy_progress_bar.value = value
	
