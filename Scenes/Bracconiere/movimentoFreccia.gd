extends Area2D  # Cambiato da Node2D a Area2D per gestire facilmente le collisioni

@export var speed: float = 300.0  # Velocità della freccia
@export var limite_x: float = 750.0  # Punto in cui eliminare la freccia
@export var danno: float = 10.0  # Danno causato dalla freccia quando colpisce

func _ready():
	# Aggiungi la freccia al gruppo "frecce"
	add_to_group("frecce")
	
	# Connetti il segnale di collisione
	body_entered.connect(_on_body_entered)
	print("Freccia inizializzata, in attesa di collisioni")

func _process(delta):
	position.x += speed * delta  # Muove la freccia
	if position.x > limite_x:  # Se supera il limite, viene distrutta
		queue_free()

func _on_body_entered(body):
	print("Collisione rilevata con:", body.name)
	if body.is_in_group("animale"):
		print("Collisione con animale!")
		# Trova il nodo del minigioco (potrebbe essere un genitore più in alto)
		var minigioco = find_parent("MinigiocoFrecce")
		
		# Chiama la funzione per ridurre la vita
		if minigioco and minigioco.has_method("freccia_colpita"):
			print("Chiamando freccia_colpita con danno:", danno)
			minigioco.freccia_colpita(danno)
		else:
			print("Errore: minigioco non trovato o manca il metodo freccia_colpita")
			print("Genitore diretto:", get_parent().name)
		
		# Elimina la freccia dopo la collisione
		queue_free()
