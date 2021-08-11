extends Resource
class_name EntityBaseResource

enum EntityTypes {PLAYER, ENEMY}
enum SkillTypes {HEALTH, BLOCK, ATTACK}

export(EntityTypes) var entity_type
export(int) var start_health
export(int) var dice_amount
var health
var activate_multiplier = false setget set_activate_multiplier
var health_skill:int = 0 setget set_health_skill
var block_skill:int = 0 setget set_block_skill
var attack_skill:int = 0 setget set_attack_skill

var skill_values = {SkillTypes.HEALTH: 0, SkillTypes.BLOCK: 0, SkillTypes.ATTACK: 0}

signal entity_skill_values_changed
signal skill_values_cleared
signal entity_health_value_changed

func set_start_health():
	health = start_health
	emit_signal("entity_health_value_changed", entity_type, health)

func add_health(amount):
	health += amount
	if health > start_health:
		health = start_health
	emit_signal("entity_health_value_changed", entity_type ,health)

func take_health(amount):
	health -= amount
	if health < 0:
		health = 0
	emit_signal("entity_health_value_changed", entity_type, health)


func set_health_skill(amount):
	if activate_multiplier:
		health_skill += amount
		health_skill *= 2
	else:
		if amount == 0:
			health_skill = 0
		else:
			health_skill += amount
	skill_values[SkillTypes.HEALTH] = health_skill
	emit_signal("entity_skill_values_changed",EntityTypes.PLAYER, skill_values)

func set_block_skill(amount):
	if activate_multiplier:
		block_skill += amount
		block_skill *= 2
	else:
		if amount == 0:
			block_skill = 0
		else:
			block_skill += amount
	skill_values[SkillTypes.BLOCK] = block_skill
	emit_signal("entity_skill_values_changed",EntityTypes.PLAYER, skill_values)

func set_attack_skill(amount):
	if activate_multiplier:
		attack_skill += amount
		attack_skill *= 2
	else:
		if amount == 0:
			attack_skill = 0
		else:
			attack_skill += amount
	skill_values[SkillTypes.ATTACK] = attack_skill
	emit_signal("entity_skill_values_changed",EntityTypes.PLAYER, skill_values)

func set_activate_multiplier(_activate_multiplier):
	activate_multiplier = _activate_multiplier
	set_health_skill(0)
	set_block_skill(0)
	set_attack_skill(0)

func clear_skill_values():
	health_skill = 0
	block_skill = 0
	attack_skill = 0
	activate_multiplier = false
	emit_signal("skill_values_cleared")

