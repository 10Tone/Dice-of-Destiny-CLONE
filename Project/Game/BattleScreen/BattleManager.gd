extends Node2D

enum TurnStates {START_TURN, PLAYER_TURN}
enum SkillTypes {HEALTH, BLOCK, ATTACK}
enum EntityTypes {PLAYER, ENEMY}

export var dice_controller = NodePath()
export var enemy_turn_simulator = NodePath()
export var roll_button = NodePath()
export var fight_button = NodePath()
export var undo_button = NodePath()
export var dices_display = NodePath()
export var seven_multiplier = NodePath()
export var healthbar_display = NodePath()
export var skills_display = NodePath()
export var win_loose_popup = NodePath()
onready var _dice_controller = get_node(dice_controller)
onready var _enemy_turn_simulator = get_node(enemy_turn_simulator)
onready var _roll_button = get_node(roll_button)
onready var _fight_button = get_node(fight_button)
onready var _undo_button = get_node(undo_button)
onready var _dices_display = get_node(dices_display)
onready var _seven_multiplier = get_node(seven_multiplier)
onready var _healthbar_display = get_node(healthbar_display)
onready var _skills_display =get_node(skills_display)
onready var _win_loose_popup = get_node(win_loose_popup)

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
		
	if _undo_button:
		_undo_button.connect("button_down", self, "on_undo_button_down")

	if !_fight_button:
		print_debug("fight button not connected")

	if _healthbar_display:
		_player.connect("entity_health_value_changed", _healthbar_display, "on_entity_health_value_changed")
		_enemy.connect("entity_health_value_changed", _healthbar_display, "on_entity_health_value_changed")
		_player.set_start_health()
		_enemy.set_start_health()

	skills = get_tree().get_nodes_in_group("skills")
	for skill in skills:
		skill.connect("value_added_to_skill", self, "on_value_added_to_skill")
		if skill.entity_type == EntityTypes.PLAYER:
			_player.connect("entity_skill_values_changed", skill, "on_entity_skill_values_changed")
			_player.connect("skill_values_cleared", skill, "on_skill_values_cleared")
		elif skill.entity_type == EntityTypes.ENEMY:
			_enemy.connect("entity_skill_values_changed", skill, "on_entity_skill_values_changed")
			_enemy.connect("skill_values_cleared", skill, "on_skill_values_cleared")

	start_player_turn()

func start_player_turn():
	player_rolled_dices = false
	_roll_button.disabled = false
	_fight_button.disabled = false
	_player.clear_skill_values()

	check_seven_multiplier()

	yield(_fight_button, "button_down")
	_player.add_health(_player.health_skill)
	
	start_enemy_turn()

func start_enemy_turn():
	_fight_button.disabled = true
	# 1. clear dices
	rolled_dices.clear()
	_dices_display.clear_dices()
	#TODO 2. take health enemy & check enemy health <= 0
	_enemy.take_health(_player.attack_skill) #TODO animate
	if _enemy.health <= 0:
		_win_loose_popup.show_popup(true)
		return
	# 3. clear player skills
#	_player.clear_skill_values() #TODO keep block
	# 4. clear multiplier
	_seven_multiplier.clear_seven_multiplier()
	
	yield(get_tree(), "idle_frame")
	# 5. roll enemy dices
	roll_enemy_dice()
	#TODO 6. enemy value multiplier
	#TODO 7. choose skills and move dice values to skills: loop through dices
	var dice_display = _dices_display.get_child(0).get_child(0)
	var start_pos = dice_display.rect_global_position
	var target_pos = _skills_display.enemy_skill_icon_positions[SkillTypes.ATTACK]
	_enemy_turn_simulator.move_dice_to_skill(dice_display.texture, start_pos, target_pos)
	dice_display.texture = null

	yield(_enemy_turn_simulator, "icon_tween_completed")
	_enemy.attack_skill = rolled_dices[0].value
	#TODO implement multiple skills

	yield(get_tree(), "idle_frame")
	#TODO 8. use enemy skills: player health - (enemy attack - player block) a/o + enemy block + enemy health
	_player.take_health(_enemy.attack_skill)
	
	if _player.health <= 0:
		_win_loose_popup.show_popup(false)
		return
		
	yield(get_tree(), "idle_frame")
	#TODO 9. check if player health > 0

	#10. start player turn if 
	rolled_dices.clear()
	_dices_display.clear_dices()
	start_player_turn()
	_enemy.clear_skill_values()


func on_roll_button_down():
	if player_rolled_dices:
		return
	if _dice_controller:
		rolled_dices = _dice_controller.roll_dices(_player.dice_amount)
		if _dices_display:
			_dices_display.display_dice_roll(rolled_dices)
		player_rolled_dices = true
		_roll_button.disabled = true

func on_undo_button_down():
	if !player_rolled_dices:
		return
	_player.clear_skill_values()
	if _dices_display:
		_dices_display.display_dice_roll(rolled_dices)
	

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
			match _skill_type:
				SkillTypes.HEALTH:
					_enemy.health_skill = _value
				SkillTypes.BLOCK:
					_enemy.block_skill = _value
				SkillTypes.ATTACK:
					_enemy.attack_skill = _value

func check_seven_multiplier():
	yield(_seven_multiplier, "skill_multiplier_activated")
	_player.activate_multiplier = true
