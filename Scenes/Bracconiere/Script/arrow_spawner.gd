extends Sprite2D

@export var freccia_texture: Texture  # Assegna la texture della freccia nell'Inspector
@export var speed: float = 200.0  # Velocità della freccia
@export var spawn_rate: float = 3 # Tempo tra uno spawn e l'altro
@export var spawn_time_limit: float = 10.0  # Dopo quanti secondi fermare lo spawn

var spawn_timer = 0.0
var stop_spawn_timer = 0.0
var spawning = true

# Funzione chiamata ogni frame
func _process(delta):
	# Gestisce lo spawn della freccia
	if spawning:
		spawn_timer += delta
		if spawn_timer >= spawn_rate:
			_spawn_freccia()  # Posiziona la freccia (se non esiste già una freccia)

		# Ferma lo spawn dopo il tempo limite
		stop_spawn_timer += delta
		if stop_spawn_timer >= spawn_time_limit:
			spawning = false  # Ferma la generazione di nuove frecce

	# Se la freccia è visibile, la muove verso destra
	##if is_inside_tree():  # Se la freccia è ancora nella scena
		position.x += speed * delta  # Muove la freccia verso destra
		
		# Se la freccia esce dallo schermo (fuori dalla vista), resetta la freccia
		if position.x > 160:  # Usa la dimensione dello schermo
			_freccia_reset()

# Funzione per posizionare la freccia fuori dallo schermo
func _spawn_freccia():
	position = Vector2(-460, randf_range(-313, 181))  # Posiziona la freccia con altezza tra -313 e 181
	texture = freccia_texture  # Imposta la texture della freccia
	print("Freccia spawnata a altezza Y: ", position.y)

# Funzione per resettare la freccia (quando è fuori dallo schermo)
func _freccia_reset():
	print("Freccia distrutta a: ", position)
	queue_free()  # Rimuove la freccia dalla scena
	spawning = true  # Permette il respawn di una nuova freccia
	stop_spawn_timer = 0.0  # Reset del timer per fermare lo spawn
