extends PopupDialog

onready var _win_loose_label = get_node("WinLooseLabel")

func show_popup(fight_won):
	if fight_won:
		_win_loose_label.text = "You Won!"
	else:
		_win_loose_label.text = "You Loose!"
	popup_centered()
