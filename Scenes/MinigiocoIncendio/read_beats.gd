extends Control

var beat_times = [] # Lista di tempi dei beat, letti dal file
var note_scene = preload("res://Scenes/MinigiocoIncendio/SubScenes/Note.tscn")
var bpm = 120 # Valore di default BPM
var fire_type = "small" # Tipo di fuoco: piccolo, medio, grande


func _ready():
	load_beat_times("res://Scenes/MinigiocoIncendio/beats.txt") # Carica i tempi del beat
	spawn_notes()

# Funzione per la lettura e salvataggio dei beat all'interno della lista
func load_beat_times(path):
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		bpm = file.get_line() # Prende il primo rigo, ovvero il BPM che legge nel file, e lo salva
		print("Sono il BPM!", bpm)
		while not file.eof_reached():
			var line = file.get_line()
			if line.is_valid_float():
				beat_times.append(float(line)) # Salva i tempi del beat che legge nel file
				print("Sto appendendo i tempi correttamente!\n")
				print(line)
	else:
		print("Errore!!")

# Funzione che cicla su tutti i tempi nella lista
func spawn_notes():
	for time in beat_times:
		create_note_at_time(time)

# Funzione che spawna la scena "Note" (spawna le note) in una certa posizione iniziale
func create_note_at_time(time):
	var note = note_scene.instantiate()
	note.position = Vector2(640, -50) # La nota parte sopra lo schermo, ma dovrei definire un'area specifica da cui dovrebbe partire
	note.set_meta("spawn_time", time)
	note.set_meta("fire_type", fire_type) # Passa il tipo di fuoco alla nota
	note.set_meta("bpm", bpm)
	#print("Vengo spawnataaa ayaya")
	add_child(note)