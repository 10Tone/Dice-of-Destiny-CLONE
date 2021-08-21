extends Control

enum SkillTypes {HEALTH, BLOCK, ATTACK}

export var enemy_attack_skill_icon = NodePath()
export var enemy_block_skill_icon = NodePath()
export var enemy_health_skill_icon = NodePath()

onready var _enemy_attack_skill_icon = get_node(enemy_attack_skill_icon)
onready var _enemy_block_skill_icon = get_node(enemy_block_skill_icon)
onready var _enemy_health_skill_icon = get_node(enemy_health_skill_icon)

var enemy_skill_icon_positions = {}

func _ready():
	enemy_skill_icon_positions[SkillTypes.ATTACK] = _enemy_attack_skill_icon.rect_global_position
	enemy_skill_icon_positions[SkillTypes.BLOCK] = _enemy_block_skill_icon.rect_global_position
	enemy_skill_icon_positions[SkillTypes.HEALTH] = _enemy_health_skill_icon.rect_global_position

