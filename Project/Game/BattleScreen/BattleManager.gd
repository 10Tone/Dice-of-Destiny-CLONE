extends Node2D

enum TurnStates {START_TURN, PLAYER_TURN}
enum SkillTypes {HEALTH, BLOCK, ATTACK}
enum EntityTypes {PLAYER, ENEMY}

export var dice_controller = NodePath()
export var roll_button = NodePath()
export var fight_button = NodePath()
export var dices_display = NodePath()
export var seven_multiplier = NodePath()
export var healthbar_display = NodePath()
onready var _dice_controller = get_node(dice_controller)
onready var _roll_button = get_node(roll_button)
onready var _fight_button = get_node(fight_button)
onready var _dices_display = get_node(dices_display)
onready var _seven_multiplier = get_node(seven_multiplier)
onready var _healthbar_display = get_node(healthbar_display)

onready var _player = load("res://Project/Resources/Entities/Player/PlayerEntity.tres")
onready var _enemy = load("res://Project/Resources/Entities/Enemies/EnemyEntity.tres")

var skills
var rolled_dices = []
var player_rolled_dices = false

func _ready():
	if !_player:
		print_debug("Player resource not loaded")

	if !_enemy:
		print_debug("Enemy resource not loaded")

	if _roll_button:
		_roll_button.connect("button_down", self, "on_roll_button_down")

	if !_fight_button:
		print_debug("fight button not connected")

	if _healthbar_display:
		_player.connect("entity_health_value_changed", _healthbar_display, "on_entity_health_value_changed")
		_enemy.connect("entity_health_value_changed", _healthbar_display, "on_entity_health_value_changed")
		_player.set_start_health()
		_enemy.set_start_health()

	skills = get_tree().get_nodes_in_group("entity")
	for skill in skills:
		skill.connect("value_added_to_skill", self, "on_value_added_to_skill")
		_player.connect("entity_skill_values_changed", skill, "on_entity_skill_values_changed")
		_player.connect("skill_values_cleared", skill, "on_skill_values_cleared")

	start_player_turn()

func start_player_turn():
	_roll_button.disabled = false
	_player.clear_skill_values()

	check_seven_multiplier()

	yield(_fight_button, "button_down")

	start_enemy_turn()

func start_enemy_turn():
	rolled_dices.clear()
	_dices_display.clear_dices()
	_enemy.take_health(_player.attack_skill)
	_player.clear_skill_values()
	_seven_multiplier.clear_seven_multiplier()
	
	yield(get_tree(), "idle_frame")
	roll_enemy_dice()
	

func on_roll_button_down():
	if player_rolled_dices:
		return
	if _dice_controller:
		rolled_dices = _dice_controller.roll_dices(_player.dice_amount)
		if _dices_display:
			_dices_display.display_dice_roll(rolled_dices)
		player_rolled_dices = true
		_roll_button.disabled = true

func roll_enemy_dice():
	if _dice_controller:
		rolled_dices = _dice_controller.roll_dices(_enemy.dice_amount)
		if _dices_display:
			_dices_display.display_dice_roll(rolled_dices)

func on_value_added_to_skill(_node, _value, _skill_type, _entity_type):
	match _entity_type:
		EntityTypes.PLAYER:
			match _skill_type:
				SkillTypes.HEALTH:
					_player.health_skill = _value
				SkillTypes.BLOCK:
					_player.block_skill = _value
				SkillTypes.ATTACK:
					_player.attack_skill = _value
		EntityTypes.ENEMY:
			pass

func check_seven_multiplier():
	yield(_seven_multiplier, "skill_muliplier_activated")
	_player.activate_multiplier = true
