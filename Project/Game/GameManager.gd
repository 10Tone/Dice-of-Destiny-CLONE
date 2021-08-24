extends Node2D

const BattleScreen = preload("res://Project/Game/BattleScreen/BattleScreen.tscn")

var battle_screen

func _ready():
	var _err = GlobalEvents.connect("reload_button_pressed", self, "on_reload_button_pressed")
	load_battle_screen()

func load_battle_screen() -> void:
	battle_screen = BattleScreen.instance()
	add_child(battle_screen)

func reload_battle_screen():
	battle_screen.queue_free()
	yield(get_tree(), "idle_frame")
	call_deferred("load_battle_screen")

func on_reload_button_pressed():
	reload_battle_screen()
