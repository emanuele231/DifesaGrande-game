extends Node2D

var spawn_time : float
var speed : float = 200  # Velocità di discesa delle note, regolabile
var bpm : float = 120  # BPM della canzone (da usare per calcolare il movimento)
var fire_type : String # Tipo di fuoco che definisce la difficoltà (piccolo, medio, grande)

func _ready():
    spawn_time = get_meta("spawn_time")  # Ottieni il tempo di spawn passato dal nodo principale
	fire_type = get_meta("fire_type") # Ottieni il tipo di fuoco
	bpm = get_meta("bpm")
	speed = calculate_speed(bpm, fire_type) 
    set_process(true)  # Inizia a processare il movimento

# Funzione che in base al tipo di fuoco calcola la velocità di discesa delle note
func calculate_speed(bpm, fire_type):
	var base_speed = 200
	var speed_multiplier = 1.0

	match fire_type:
		"small":
			speed_multiplier = 0.8  # Fuoco piccolo = velocità di discesa più lenta, meno note?, più errori ammessi
		"medium":
			speed_multiplier = 1.0  # Fuoco medio = velocità normale
		"large":
			speed_multiplier = 1.3  # Fuoco grande = velocità massimizzata
	
	var beat_interval = 60 / bpm  # Tempo tra i battiti in secondi
	return base_speed * speed_multiplier * beat_interval


# Funzione che processa le note
func _process(delta):
    # Calcola il tempo trascorso dal momento dello spawn
    var elapsed_time = get_tree().get_time_in_seconds() - spawn_time
    
    # Muovi la nota verso il basso (velocità dipendente dal BPM)
    position.y += speed * delta
    
    # Puoi usare il BPM per calcolare la velocità di movimento in modo più preciso
    # Ad esempio, con un BPM di 120, il tempo tra i beat sarà di 0.5 secondi:
    #var beat_interval = 60 / bpm  # Tempo per un battito
    #if elapsed_time >= beat_interval:
        # La nota ha raggiunto il battito, potresti aggiungere un evento per interagire con la nota
        # Come la distruzione della nota, la cattura, ecc.
        #queue_free()  # La nota scompare quando arriva a destinazione

	if is_pressed_correct_key():  # Se l'utente ha premuto il tasto giusto
            queue_free()  # Nota distrutta
        else:
            # Puoi aggiungere un comportamento per errore
            print("Errore! Nota mancata.")
            queue_free()

# Funzione per controllare che l'utente prema la nota correttamente

