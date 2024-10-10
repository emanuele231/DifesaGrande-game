extends Control

var timer_duration: int = 300
var current_time: float = 300 
var timer_running: bool = false
var end: bool = false


func _ready():
	$Label.z_index = 3
	get_node("../dialogo_min_2")._timer_callback = self  

func _timer():
	timer_running = true


func _process(delta):
	if timer_running == true:
		current_time -= delta  
		if current_time <= 0:
			current_time = 0
			timer_running = false
			end = true
			Engine.time_scale = 0  
		update_timer()

func update_timer():
	var time_left = round(current_time)
	$Label.text = str(time_left)
	$"../punteggio/punti".text = str(time_left)
