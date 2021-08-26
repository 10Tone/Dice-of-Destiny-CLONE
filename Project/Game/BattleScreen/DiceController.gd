class_name DiceController
extends Node2D

var rng = RandomNumberGenerator.new()
onready var dices = []

func _ready():
	rng.randomize()
	dices.append(load("res://Project/Resources/Dice/Dice_01.tres"))
	dices.append(load("res://Project/Resources/Dice/Dice_02.tres"))
	dices.append(load("res://Project/Resources/Dice/Dice_03.tres"))
	dices.append(load("res://Project/Resources/Dice/Dice_04.tres"))
	dices.append(load("res://Project/Resources/Dice/Dice_05.tres"))
	dices.append(load("res://Project/Resources/Dice/Dice_06.tres"))

func roll_dices(dice_amount: int) -> Array:
	if dice_amount > 3:
		print_debug("maximum of three dices")
		return []

	var throw = []
	for _i in range(dice_amount):
		throw.append( get_dice(rng.randi_range(1, 6)))
	return throw

#get the dice resource
func get_dice(value: int) -> Array:
	match value:
		1: 
			return dices[0]
		2: 
			return dices[1]
		3: 
			return dices[2]
		4: 
			return dices[3]
		5: 
			return dices[4]
		6: 
			return dices[5]
	return []
