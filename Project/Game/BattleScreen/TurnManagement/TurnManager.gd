class_name TurnManager
extends Node

var dice_controller: DiceController

var rolled_dices = []

signal turn_finished
signal roll_button_pressed
signal fight_button_pressed

func start_turn(entity: EntityBaseClass) -> void:
	rolled_dices = []
	
	#ROLL STATE
	# yield till dices rolled
	if entity.entity_type == GlobalEnums.EntityTypes.PLAYER:
		yield(self, "roll_button_pressed")

	if dice_controller:
		rolled_dices = dice_controller.roll_dices(entity.dice_amount)
		GlobalEvents.emit_signal("dices_rolled", rolled_dices)
	#CHOOSE STATE
	#yield till fight button pressed
	if entity.entity_type == GlobalEnums.EntityTypes.PLAYER:
		yield(self, "fight_button_pressed")
	if entity.entity_type == GlobalEnums.EntityTypes.ENEMY:
		yield(get_tree().create_timer(2.0), "timeout")
	emit_signal("turn_finished")
	
	#FIGHT STATE
	pass


func _on_RollButton_button_down() -> void:
	emit_signal("roll_button_pressed")


func _on_FightButton_button_down() -> void:
	emit_signal("fight_button_pressed")
