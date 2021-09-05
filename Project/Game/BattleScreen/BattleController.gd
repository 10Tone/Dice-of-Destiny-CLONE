extends Node2D

onready var _battle_control_buttons = get_node("HUD/BattleControlButtons")
onready var _dice_controller: DiceController = get_node("DiceController")
onready var _turn_manager: TurnManager = get_node("TurnManager")

onready var _player = get_node("Entities/Player")
onready var _enemy = get_node("Entities/Enemy")

var entity_has_died: bool = false
var turn_amount: int = 0

func _ready() -> void:
	GlobalEvents.connect("entity_died", self, "on_entity_died")
	_turn_manager.dice_controller = _dice_controller
	_turn_manager.connect("turn_finished", self, "on_turn_finished")
	start_battle()
	
func start_battle() -> void:
	# start intro animations
	#yield till animations finished
	battle_routine()
	
func battle_routine() -> void:

	turn_amount += 1
	GlobalEvents.emit_signal("new_turn_started", turn_amount)
	#start player turn
	
	_turn_manager.start_turn(_player)
	
	yield(_turn_manager, "turn_finished")
	print("player turn finished")
	_turn_manager.start_turn(_enemy)
	
	yield(_turn_manager, "turn_finished")
	print("enemy turn finished")
	
	
	if !entity_has_died:
		battle_routine()
		
	
	
func on_entity_died(_entity_type) -> void:
	entity_has_died = true

func on_turn_finished() -> void:
	pass
