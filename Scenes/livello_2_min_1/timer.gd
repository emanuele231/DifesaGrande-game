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
		
		#se il minigioco viene fermato dal metodo _on_catturato_body_entered di player viene controllato il punteggio migliore ed eventualmente aggiornato. Invece se finisce il tempo il punteggio è 0 e non è necessario aggiornare in ogni caso perchè sarebbe 0
	if Engine.time_scale == 0:
		if timer_running == true:
			SingletonStats.set_punteggio(round(current_time),1)

func update_timer():
	var time_left = round(current_time)
	$Label.text = str(time_left)
	$"../punteggio/punti".text = str(time_left)
