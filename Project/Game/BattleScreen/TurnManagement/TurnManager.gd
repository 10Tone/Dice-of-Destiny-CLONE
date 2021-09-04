class_name TurnManager
extends Node

var dice_controller: DiceController

var rolled_dices = []

signal turn_finished
signal roll_button_pressed

func start_turn(entity: EntityBaseClass):
	#ROLL STATE
	# yield till dices rolled
	yield(self, "roll_button_pressed")
	if dice_controller:
		rolled_dices = dice_controller.roll_dices(3)
		GlobalEvents.emit_signal("dices_rolled", rolled_dices)
	#CHOOSE STATE
	#yield till fight button pressed
	
	#FIGHT STATE
	pass


func _on_RollButton_button_down() -> void:
	emit_signal("roll_button_pressed")
