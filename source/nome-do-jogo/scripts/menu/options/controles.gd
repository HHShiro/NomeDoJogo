extends VBoxContainer

@export var up_button: Button
@export var down_button: Button
@export var left_button: Button
@export var right_button: Button

const ACTIONS = {
	"up": "move_up",
	"down": "move_down",
	"left": "move_left",
	"right": "move_right"
}

var waiting_for_input: String = ""

func _ready() -> void:
	update_button_labels()
	
	up_button.pressed.connect(on_rebind_button_pressed.bind("up"))
	down_button.pressed.connect(on_rebind_button_pressed.bind("down"))
	left_button.pressed.connect(on_rebind_button_pressed.bind("left"))
	right_button.pressed.connect(on_rebind_button_pressed.bind("right"))

func get_button(diretion: String) -> Button:
	match diretion:
		"up": return up_button
		"down": return down_button
		"left": return left_button
		"right": return right_button
		_: return null

func update_button_label(direction: String):
	var action_name = ACTIONS[direction]
	var events = InputMap.action_get_events(action_name)
	
	var label_text = "Unassigned"
	
	if events.size() > 0:
		var event = events[0]
		if event is InputEventKey:
			if event.keycode != 0:
				label_text = OS.get_keycode_string(event.keycode)
			elif event.physical_keycode != 0:
				label_text = OS.get_keycode_string(event.physical_keycode)
	
	var btn = get_button(direction)
	btn.text = "%s" % [label_text]

func update_button_labels():
	for dir in ACTIONS.keys():
		update_button_label(dir)

func on_rebind_button_pressed(diretion: String):
	waiting_for_input = diretion
	var btn = get_button(diretion)
	btn.text = "..."
	set_process_input(true)

func _input(event):
	if waiting_for_input == "":
		return
	
	if event is InputEventKey and event.pressed:
		var diretion = waiting_for_input
		var action_name = ACTIONS[diretion]
	
		InputMap.action_erase_events(action_name)
		InputMap.action_add_event(action_name, event)
		
		update_button_label(diretion)
		
		waiting_for_input = ""
		set_process_input(false)
