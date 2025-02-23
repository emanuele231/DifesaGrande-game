extends State

@onready var backButton = $BackButton
@onready var bracconiereBar = $"../../ConvinzioneBracconiere"

var frase_buttons = []  # Inizialmente una lista vuota

var frasi = [
	{"testo": "Cacciare è sbagliato!", "danno": 20},
	{"testo": "Gli animali meritano di vivere.", "danno": 15},
	{"testo": "La natura è più importante dei soldi!", "danno": 25},
	{"testo": "Sei migliore di così.", "danno": 10},
	{"testo": "Trova un altro lavoro, ti aiuterò.", "danno": 30}
]

func enter():
	# Trova i bottoni solo quando lo stato viene attivato
	var frasi_node = get_node_or_null("CombatScene/ParlaUI/Bottom/Frasi")
	if frasi_node:
		frase_buttons = frasi_node.get_children()
		print("Bottoni trovati:", frase_buttons)
	else:
		print("ERRORE: Nodo 'Frasi' non trovato!")
		return  # Esce dalla funzione se il nodo non esiste

	# Nasconde tutti i bottoni inizialmente
	for button in frase_buttons:
		button.visible = false

	# Sceglie 3 frasi casuali
	var scelte = frasi.duplicate()
	scelte.shuffle()
	scelte = scelte.slice(0, 3)

	# Assegna le frasi ai bottoni
	for i in range(scelte.size()):
		frase_buttons[i].text = scelte[i]["testo"]
		frase_buttons[i].visible = true
		frase_buttons[i].pressed.connect(_on_frase_pressed.bind(scelte[i]["danno"]))

	# Mostra il pulsante indietro
	backButton.visible = true
	backButton.pressed.connect(_on_back_pressed)

func exit():
	# Disconnette i segnali per evitare problemi
	for button in frase_buttons:
		if button.pressed.is_connected(_on_frase_pressed):
			button.pressed.disconnect(_on_frase_pressed)
		button.visible = false

	if backButton.pressed.is_connected(_on_back_pressed):
		backButton.pressed.disconnect(_on_back_pressed)
	backButton.visible = false

func _on_frase_pressed(danno: int):
	bracconiereBar.value -= danno  # Riduce la barra del bracconiere
	print("Danno inflitto:", danno, " - Valore attuale:", bracconiereBar.value)

	if bracconiereBar.value <= 0:
		get_parent().transition_to("PunteggioState")
	else:
		get_parent().transition_to("DifesaState")

func _on_back_pressed():
	get_parent().transition_to("SelectState")
