extends Control


func display_dice_roll(dices):
	for i in range(get_child(0).get_children().size()):
		if get_child(0):
			get_child(0).get_child(i).display_dice(dices[i])

