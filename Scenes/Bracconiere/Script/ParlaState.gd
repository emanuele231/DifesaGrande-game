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

@onready var neutro = get_parent().get_parent().get_node("UI/Emote/Neutro")
@onready var triste = get_parent().get_parent().get_node("UI/Emote/Triste")
@onready var arrabbiato = get_parent().get_parent().get_node("UI/Emote/Arrabbiato")

@onready var audioPlayer = get_parent().get_parent().get_node("Effetti")

var frasi_semplici = [
	{"testo": "Cacciare è sbagliato!", "danno": 10, "gruppo": "semplici"},
	{"testo": "Gli animali meritano di vivere tanto quanto te!", "danno": 15, "gruppo": "semplici"},
	{"testo": "La natura è più importante dei soldi!", "danno": 15, "gruppo": "semplici"}
]

var frasi_leggi = [
	{"testo": "La caccia con metodi di uccisione di massa è vietata!", "danno": 20, "gruppo": "leggi"},
	{"testo": "Uccidere specie protette è un reato, esistono leggi che le tutelano!", "danno": 20, "gruppo": "leggi"}
]

var frasi_complete = [
	{"testo": "Il bracconaggio distrugge l'equilibrio naturale della fauna selvatica!", "danno": 25, "gruppo": "complete"},
	{"testo": "Gli habitat stanno scomparendo, ogni animale ucciso è una perdita enorme!", "danno": 25, "gruppo": "complete"}
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
	if not backButton.visible:
		backButton.visible = true
		
	button1.visible = true
	button2.visible = true
	button3.visible = true
	
	playerBar.visible = false
	
	backButton.pressed.connect(_on_back_pressed)

	# Determina l'ordine casuale dei gruppi per i tre bottoni
	var gruppi_casuali = get_random_groups()

	var gruppi_mappa = {
		"semplici": frasi_semplici,
		"leggi": frasi_leggi,
		"complete": frasi_complete
	}

	# Seleziona una frase casuale per ciascun bottone
	var frase1 = get_random_element(gruppi_mappa[gruppi_casuali[0]])
	var frase2 = get_random_element(gruppi_mappa[gruppi_casuali[1]])
	var frase3 = get_random_element(gruppi_mappa[gruppi_casuali[2]])

	label1.text = frase1["testo"]
	label2.text = frase2["testo"]
	label3.text = frase3["testo"]

	button1.pressed.connect(_on_frase_pressed.bind(frase1["danno"], frase1["gruppo"]))
	button2.pressed.connect(_on_frase_pressed.bind(frase2["danno"], frase2["gruppo"]))
	button3.pressed.connect(_on_frase_pressed.bind(frase3["danno"], frase3["gruppo"]))

func exit():
	parlaUI.visible = false
	neutro.visible = false
	triste.visible = false
	arrabbiato.visible = false

	button1.pressed.disconnect(_on_frase_pressed)
	button2.pressed.disconnect(_on_frase_pressed)
	button3.pressed.disconnect(_on_frase_pressed)
	
	button1.visible = false
	button2.visible = false
	button3.visible = false

	if backButton.pressed.is_connected(_on_back_pressed):
		backButton.pressed.disconnect(_on_back_pressed)
	backButton.visible = false

func _on_frase_pressed(danno: int, gruppo: String):
	PunteggioBracconiere.aggiungi_punti(danno)

	# Scegli il suono e l'emote in base al gruppo della frase scelta
	var sound_path = ""
	var emote = null

	match gruppo:
		"semplici":
			emote = neutro
			sound_path = "res://Scenes/Bracconiere/Sound Effects/happy-pop-1-185286.mp3"
		"leggi":
			emote = triste
			sound_path = "res://Scenes/Bracconiere/Sound Effects/happy-pop-1-185286.mp3"
		"complete":
			emote = arrabbiato
			sound_path = "res://Scenes/Bracconiere/Sound Effects/happy-pop-1-185286.mp3"

	if emote:
		fade_in_emote(emote)  # Attiva la dissolvenza dell'emote scelta

	if sound_path:
		audioPlayer.stream = load(sound_path)
		audioPlayer.play()
	
	await animate_bracconiere_bar(danno)
	await get_tree().create_timer(0.5).timeout

	if bracconiereBar.value <= 0:
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

# Funzione per applicare la dissolvenza (Tween) all'emote selezionata
func fade_in_emote(emote: TextureRect):
	emote.visible = true
	emote.modulate.a = 0.0  # Inizia trasparente

	var tween = create_tween()
	tween.tween_property(emote, "modulate:a", 1.0, 0.5)  # Fade-in in 0.5s
