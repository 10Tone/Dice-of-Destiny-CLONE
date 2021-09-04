extends Control

onready var _roll_button: TextureButton = get_node("ActionButtonsBackground/HBoxContainer/RollButton")
onready var _fight_button: TextureButton = get_node("ActionButtonsBackground/HBoxContainer/FightButton")

func _on_RollButton_button_down() -> void:
	_roll_button.disabled = true


func _on_FightButton_button_down() -> void:
	_fight_button.disabled = true
