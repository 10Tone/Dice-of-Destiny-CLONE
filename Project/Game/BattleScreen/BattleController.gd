extends Node2D

onready var _battle_control_buttons = get_node("HUD/BattleControlButtons")
onready var _dice_controller: DiceController = get_node("DiceController")
onready var _turn_manager: TurnManager = get_node("TurnManager")

onready var _player = get_node("Entities/Player")
onready var _enemy = get_node("Entities/Enemy")

func _ready() -> void:
	_turn_manager.dice_controller = _dice_controller
	start_battle()
	
func start_battle():
	# start intro animations
	#yield till animations finished
	
	#start player turn
	_turn_manager.start_turn(_player)
	pass
