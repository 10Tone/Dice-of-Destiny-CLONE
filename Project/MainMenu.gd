extends Node2D

signal start_button_pressed
       
func _on_StartButton_button_down():
    emit_signal("start_button_pressed")

func _on_DebugModeButton_toggled(button_pressed):
    GlobalSettings.debug_mode = button_pressed