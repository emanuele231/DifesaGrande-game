extends Control

var timer_duration: int = 15
var current_time: float = 15  # Inizia dal tempo massimo
var timer_running: bool = false
var end: bool = false

func _ready():
	$Label.z_index = 3
	# Avvia il timer solo dopo che l'etichetta ha il z_index corretto o dopo un evento specifico
	call_deferred("check_and_start_timer")  # Posticipa l'esecuzione per assicurarsi che il z_index sia stato applicato

func check_and_start_timer():
	# Controlla se il z_index dell'etichetta è corretto prima di avviare il timer
	if $Label.z_index == 3:
		start_timer()
	else:
		print("Il z_index non è corretto per avviare il timer.")

func start_timer():
	timer_running = true
	end = false
	Engine.time_scale = 1  # Assicurati che il tempo di gioco scorra normalmente
	print("Timer avviato")

func _process(delta):
	if timer_running:
		current_time -= delta  # Sottrai il tempo trascorso
		if current_time <= 0:
			current_time = 0
			timer_running = false
			end = true
			Engine.time_scale = 0  # Ferma il tempo in gioco
		update_timer()

func update_timer():
	var time_left = round(current_time)
	$Label.text = str(time_left)
