extends Control

var timer_duration = 25
var current_time = 1
var timer_running: bool = false
var end: bool = false
var carta_script = preload("res://Scenes/livello_1/Bidone_carta.gd")
var carta = carta_script.new()

func _ready():
	get_node("../../../Sprite2D/spiegazione_1_1")._timer_callback = self
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	$capienza_sacco.z_index = 3
	$organico_rimasto.z_index = 3
	$timer.z_index = 3
	$"../pannello punteggio finale".z_index = 3
	$"../pannello punteggio finale".hide()
	$"info-point".hide()
	$info.z_index = 3
func _timer():
	timer_running = true
	$"../pannello punteggio finale".hide()

func _process(delta):
	var p_position = position
	var min_limit = Vector2(-352, -464) 
	var max_limit = Vector2(1040, 1232) 

	p_position.x = clamp(p_position.x, min_limit.x, max_limit.x)
	p_position.y = clamp(p_position.y, min_limit.y, max_limit.y)
	position = p_position
	$Control.show()
	if timer_running == true:
		current_time += delta
		end = false
		if current_time >= timer_duration:
			timer_running = false
			$"../pannello punteggio finale".show()
			punteggio_finale()
			current_time = timer_duration
			end = true
			Engine.time_scale = 0
			$Control.hide()
		update_timer()


func update_timer():
	var time_left = round(timer_duration - current_time)
	$timer.text = str(time_left)
	
func punteggio_finale():
	var puntiC_s = get_node("/root/PuntiSingleton")
	var punti = puntiC_s.get_custom_puntiC()
	
	var puntiI_s = get_node("/root/PuntiSingleton")
	var puntiI = puntiI_s.get_custom_puntiI()
	
	var puntiP_s = get_node("/root/PuntiSingleton")
	var puntiP = puntiP_s.get_custom_puntiP()
	
	var puntiO_s = get_node("/root/PuntiSingleton")
	var puntiO = puntiO_s.get_custom_puntiO()
	
	var somma_punti = punti + puntiI + puntiP + puntiO
	
	$"../pannello punteggio finale/punti".text = str(somma_punti)
		
	
	


func _on_info_button_down():
	Engine.time_scale = 0
	$"info-point".show()
