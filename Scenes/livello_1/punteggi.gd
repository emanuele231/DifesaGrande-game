extends Control

var timer_duration = 3
var current_time = 1
var timer_running: bool = false
var end: bool = false
	
func _ready():
	get_node("../../Sprite2D/spiegazione_1_1")._timer_callback = self
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	$capienza_sacco.z_index = 3
	$organico_rimasto.z_index = 3
	$timer.z_index = 3


func _timer():
	timer_running = true

func _process(delta):
	var p_position = global_position
	var min_limit = Vector2(-352, -464) 
	var max_limit = Vector2(1040, 1232) 

	p_position.x = clamp(p_position.x, min_limit.x, max_limit.x)
	p_position.y = clamp(p_position.y, min_limit.y, max_limit.y)
	global_position = p_position
	if timer_running == true:
		current_time += delta
		end = false
		if current_time >= timer_duration:
			timer_running = false
			current_time = timer_duration
			end = true
		update_timer()


func update_timer():
	var time_left = round(timer_duration - current_time)
	$timer.text = str(time_left)
	

		
	
	
