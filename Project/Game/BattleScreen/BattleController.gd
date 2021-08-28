extends Node2D

onready var _dice_controller: DiceController = DiceController.new()
onready var _turn_manager: TurnManager = TurnManager.new()

func _ready() -> void:
	start_battle()
	
func start_battle():
	# start intro animations
	#yield till animations finished
	
	#start player turn
	_turn_manager.start_turn(GlobalEnums.EntityTypes.PLAYER)
	pass
