extends State

@onready var parlaUI = get_parent().get_parent().get_node("UI/ParlaUI")
@onready var playerBar = get_parent().get_parent().get_node("UI/PlayerBar")
@onready var backButton = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Indietro/BackButton")
@onready var bracconiereBar = get_parent().get_parent().get_node("UI/ConvinzioneBracconiere")
@onready var bracconiereBarLabel = get_parent().get_parent().get_node("UI/ConvinzioneBracconiere/Label")

@onready var button1 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button1")
@onready var label1 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button1/Label1")
@onready var button2 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button2")
@onready var label2 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button2/Label2")
@onready var button3 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button3")
@onready var label3 = get_parent().get_parent().get_node("UI/ParlaUI/Bottom/Frasi/Button3/Label3")

@onready var audioPlayer = get_parent().get_parent().get_node("Effetti")  # Aggiunto per il suono

var frasi_semplici = [
	{"testo": "Cacciare è sbagliato!", "danno": 10},
	{"testo": "Gli animali meritano di vivere tanto quanto te!", "danno": 15},
	{"testo": "La natura è più importante dei soldi!", "danno": 15},
	{"testo": "Sei migliore di così.", "danno": 10},
	{"testo": "Ci sono alternative alla caccia se vuoi divertirti!", "danno": 10},
	{"testo": "Il bracconaggio può portare alla scomparsa di intere specie!", "danno": 15},
	{"testo": "Gli habitat stanno scomparendo, ogni animale ucciso è una perdita enorme!", "danno": 15}
]

var frasi_leggi = [
	{"testo": "La caccia con metodi di uccisione di massa è vietata!", "danno": 20},
	{"testo": "Uccidere specie protette è un reato, esistono leggi che le tutelano!", "danno": 20},
	{"testo": "Distruggere i nidi è vietato! Stai minacciando la biodiversità.", "danno": 20},
	{"testo": "Le Zone di Protezione Speciale non esistono per il tuo divertimento!", "danno": 20},
	{"testo": "Il commercio di uccelli selvatici è illegale! Se ti piacciono gli uccelli, inizia a fare birdwatching.", "danno": 20},
	{"testo": "Usare veleni e proiettili in piombo non solo è illegale ma inquina anche l'ambiente!", "danno": 20},
	{"testo": "Le armi silenziate per la caccia sono illegali: uccidere senza farsi sentire non dimostra abilità!", "danno": 20}
]

var frasi_complete = [
	{"testo": "Il bracconaggio distrugge l'equilibrio naturale della fauna selvatica!", "danno": 25},
	{"testo": "Gli habitat stanno scomparendo, ogni animale ucciso è una perdita enorme!", "danno": 25},
	{"testo": "Ci sono dei periodi precisi in cui è consentito cacciare! Informati e rispettali.", "danno": 25},
	{"testo": "Trappole e lacci sono crudeli e illegali. Lasciare un animale a soffrire per ore o giorni è crudele!", "danno": 25},
	{"testo": "Usare richiami elettronici per attirare gli animali è poco leale verso la natura e un reato.", "danno": 25},
	{"testo": "Sparare agli animali dalle auto o usare visori notturni è da codardi ed è severamente vietato!", "danno": 25},
	{"testo": "L'uso della balestra per la caccia è vietato. Non siamo nel Medioevo, e rischi di colpire qualcuno.", "danno": 20}
]


func get_random_element(array):
	array.shuffle()
	return array[0]

func get_random_groups():
	var gruppi = ["semplici", "leggi", "complete"]
	gruppi.shuffle()
	return gruppi

func enter():
	parlaUI.visible = true
	if backButton.visible == false:
		backButton.visible = true
		
	button1.visible = true
	button2.visible = true
	button3.visible = true
	
	playerBar.visible = false
	
	backButton.pressed.connect(_on_back_pressed)

	# Determina l'ordine casuale dei gruppi per i tre bottoni
	var gruppi_casuali = get_random_groups()

	# Mappa i gruppi alle liste di frasi corrispondenti
	var gruppi_mappa = {
		"semplici": frasi_semplici,
		"leggi": frasi_leggi,
		"complete": frasi_complete
	}

	# Seleziona una frase casuale per ciascun bottone
	var frase1 = get_random_element(gruppi_mappa[gruppi_casuali[0]])
	var frase2 = get_random_element(gruppi_mappa[gruppi_casuali[1]])
	var frase3 = get_random_element(gruppi_mappa[gruppi_casuali[2]])

	# Imposta i testi nei bottoni
	label1.text = frase1["testo"]
	label2.text = frase2["testo"]
	label3.text = frase3["testo"]

	# Connetti i bottoni alle funzioni con il danno corretto
	button1.pressed.connect(_on_frase_pressed.bind(frase1["danno"]))
	button2.pressed.connect(_on_frase_pressed.bind(frase2["danno"]))
	button3.pressed.connect(_on_frase_pressed.bind(frase3["danno"]))

func exit():
	parlaUI.visible = false

	button1.pressed.disconnect(_on_frase_pressed)
	button2.pressed.disconnect(_on_frase_pressed)
	button3.pressed.disconnect(_on_frase_pressed)
	
	button1.visible = false
	button2.visible = false
	button3.visible = false

	if backButton.pressed.is_connected(_on_back_pressed):
		backButton.pressed.disconnect(_on_back_pressed)
	backButton.visible = false

func _on_frase_pressed(danno: int):
	PunteggioBracconiere.aggiungi_punti(danno)
	await animate_bracconiere_bar(danno)  
	await get_tree().create_timer(0.5).timeout  

	if bracconiereBar.value <= 0:
		
		audioPlayer.stream = load("res://Scenes/Bracconiere/Sound Effects/cute-level-up-3-189853.mp3") 
		audioPlayer.play()  # Riproduce il suono
		playerBar.visible = false
		bracconiereBar.visible = false
		get_parent().transition_to("PunteggioState")
	else:
		get_parent().transition_to("DifesaState")

func _on_back_pressed():
	get_parent().transition_to("SelectState")

func animate_bracconiere_bar(danno: int):
	var target_value = bracconiereBar.value - danno
	if target_value < 0:
		target_value = 0

	while bracconiereBar.value > target_value:
		bracconiereBar.value -= 1
		bracconiereBarLabel.text = str(bracconiereBar.value) + "%" 
		await get_tree().create_timer(0.05).timeout
