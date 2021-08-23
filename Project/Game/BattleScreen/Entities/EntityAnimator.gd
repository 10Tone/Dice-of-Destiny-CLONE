extends Node2D

enum EntityTypes {PLAYER, ENEMY}
enum EntityStates {IDLE, SHIELD_UP, ATTACK, HIT}

export(EntityTypes) var entity_type

onready var _animation_player = $AnimationPlayer

signal entity_animation_finished(entity_state)

func _ready():
	GlobalEvents.connect("entity_state_changed", self, "on_entity_state_changed")

func on_entity_state_changed(_entity_type, _entity_state):
	if _entity_type != entity_type:
		return
		
	match _entity_state:
		EntityStates.IDLE:
			_animation_player.play("walk")
			yield(_animation_player, "animation_finished")
			emit_signal("entity_animation_finished", EntityStates.IDLE)
		EntityStates.SHIELD_UP:
			_animation_player.play("shield_prep")
			yield(_animation_player, "animation_finished")
			_animation_player.play("shield_pulse")
			yield(_animation_player, "animation_finished")
			emit_signal("entity_animation_finished", EntityStates.SHIELD_UP)
		EntityStates.ATTACK:
			_animation_player.play("shockwave")
			yield(_animation_player, "animation_finished")
			emit_signal("entity_animation_finished", EntityStates.ATTACK)
		EntityStates.HIT:
			_animation_player.play("hit")
			yield(_animation_player, "animation_finished")
			emit_signal("entity_animation_finished", EntityStates.HIT)
