extends Camera2D

@onready var minute_label = $HBoxContainer/minute
@onready var second_label = $HBoxContainer/second
var minute : int = 0
var second : int = 0



func _on_timer_timeout():
	second += 1
	
	if second >= 60:
		second = 0
		minute += 1
	minute_label.text = str(minute)
	second_label.text = str(second).lpad(2, "0")
	
