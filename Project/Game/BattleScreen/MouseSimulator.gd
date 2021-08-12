extends Node2D

var sim_mouse_drag_event = InputEventMouseMotion.new()



func simulate_leftmouse_click(_position):
    var sim_mouse_event = InputEventMouseButton.new()
    sim_mouse_event.set_button_index(1)
    sim_mouse_event.set_pressed(true)
    sim_mouse_event.position = _position
    Input.parse_input_event(sim_mouse_event)
    print(_position)

# func simulate_mouse_drag(_end_pos):
    
#     sim_mouse_event.relative = _end_pos 
#     Input.parse_input_event(sim_mouse_drag_event)