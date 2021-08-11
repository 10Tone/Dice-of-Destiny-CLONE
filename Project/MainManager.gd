extends Node2D

const Game = preload("res://Project/Game/Game.tscn")
const MainMenu = preload("res://Project/MainMenu.tscn")

var game 
var main_menu 

func _ready():
	load_main_menu()

func load_main_menu():
	if game:
		game.queue_free()
	main_menu = MainMenu.instance()
	add_child(main_menu)
	main_menu.connect("start_button_pressed", self, "on_start_button_pressed")

func load_game():
	if main_menu:
		main_menu.queue_free()
	game = Game.instance()
	add_child(game)

func on_start_button_pressed():
	load_game()
