#ParlaState.gd
extends State

@onready var parlaUI = get_parent().get_parent().get_node("ParlaUI")
@onready var playerBar = get_parent().get_parent().get_node("PlayerBar")
@onready var backButton = get_parent().get_parent().get_node("ParlaUI/Bottom/Indietro/BackButton")
@onready var bracconiereBar = get_parent().get_parent().get_node("Sprite2D/ConvinzioneBracconiere")
@onready var bracconiereBarLabel = get_parent().get_parent().get_node("Sprite2D/ConvinzioneBracconiere/Label")

# Variabili per i tre bottoni
@onready var button1 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button1")
@onready var label1 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button1/Label1")
@onready var button2 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button2")
@onready var label2 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button2/Label2")
@onready var button3 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button3")
@onready var label3 = get_parent().get_parent().get_node("ParlaUI/Bottom/Frasi/Button3/Label3")


var frase_buttons = []  # Inizialmente una lista vuota

var frasi = [
	{"testo": "Cacciare è sbagliato!", "danno": 20},
	{"testo": "Gli animali meritano di vivere.", "danno": 15},
	{"testo": "La natura è più importante dei soldi!", "danno": 25},
	{"testo": "Sei migliore di così.", "danno": 10},
	{"testo": "Trova un altro lavoro, ti aiuterò.", "danno": 30}
]

func enter():
	# Attiva la UI della scena
	parlaUI.visible = true
	if backButton.visible == false:
		backButton.visible = true
		
	# Rende visibili i bottoni quando si torna nello stato
	button1.visible = true
	button2.visible = true
	button3.visible = true
	
	# disattiva la playerBar
	playerBar.visible = false
	
	# Connetti i pulsanti
	backButton.pressed.connect(_on_back_pressed)

	# Scegli 3 frasi uniche dalla lista
	var scelte = frasi.duplicate()
	scelte.shuffle()  # Mescola le frasi
	scelte = scelte.slice(0, 3)  # Seleziona le prime 3 frasi uniche

	# Imposta il testo di ciascun bottone con le frasi
	label1.text = scelte[0]["testo"]
	label2.text = scelte[1]["testo"]
	label3.text = scelte[2]["testo"]

	# Collega ogni bottone a un'azione di danno
	button1.pressed.connect(_on_frase_pressed.bind(scelte[0]["danno"]))
	button2.pressed.connect(_on_frase_pressed.bind(scelte[1]["danno"]))
	button3.pressed.connect(_on_frase_pressed.bind(scelte[2]["danno"]))

func exit():
	# Disattiva la UI della scena
	parlaUI.visible = false
	playerBar.visible = true

	# Disconnette i segnali 
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
	await animate_bracconiere_bar(danno)  # Riduce la barra in modo graduale
	await get_tree().create_timer(0.5).timeout  # Aspetta mezzo secondo prima di cambiare stato

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
		bracconiereBarLabel.text = str(bracconiereBar.value) + "%"  # Aggiorna il testo
		await get_tree().create_timer(0.05).timeout
