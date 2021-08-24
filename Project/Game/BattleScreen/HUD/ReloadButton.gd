extends Button

func _ready():
	visible = GlobalSettings.debug_mode

func _on_ReloadButton_DEBUG_button_down():
	GlobalEvents.emit_signal("reload_button_pressed")
