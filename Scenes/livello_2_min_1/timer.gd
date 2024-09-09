extends Control

var timer_duration: int = 300
var current_time: int = 1
var timer_running: bool = false
var end: bool = false

func _ready():
	$Label.z_index = 3

func _process(delta):
	if timer_running == true:
		current_time += delta
		end = false
		if current_time >= timer_duration:
			timer_running = false
			current_time = timer_duration
			end = true
			Engine.time_scale = 0
			update_timer()


func update_timer():
	var time_left = round(timer_duration - current_time)
	$Label.text = str(time_left)
