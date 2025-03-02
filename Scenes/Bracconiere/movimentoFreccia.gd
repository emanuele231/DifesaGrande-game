extends Area2D 

@export var speed: float = 300.0 
@export var limite_x: float = 750.0  
@export var danno: float = 10.0  

func _ready():
	
	add_to_group("frecce")
	

	body_entered.connect(_on_body_entered)
	print("Freccia inizializzata, in attesa di collisioni")

func _process(delta):
	position.x += speed * delta 
	if position.x > limite_x: 
		queue_free()

func _on_body_entered(body):
	print("Collisione rilevata con:", body.name)
	if body.is_in_group("animale"):
		print("Collisione con animale!")
		
		var minigioco = find_parent("MinigiocoFrecce")
		
		if minigioco and minigioco.has_method("freccia_colpita"):
			print("Chiamando freccia_colpita con danno:", danno)
			minigioco.freccia_colpita(danno)
		else:
			print("Errore: minigioco non trovato o manca il metodo freccia_colpita")
			print("Genitore diretto:", get_parent().name)
		
		queue_free()
