#ParlaState.gd
extends State

@onready var parlaUI = get_parent().get_parent().get_node("CanvasLayer/ParlaUI")
@onready var playerBar = get_parent().get_parent().get_node("CanvasLayer/PlayerBar")
@onready var backButton = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Indietro/BackButton")
@onready var bracconiereBar = get_parent().get_parent().get_node("CanvasLayer/Sfondo/ConvinzioneBracconiere")
@onready var bracconiereBarLabel = get_parent().get_parent().get_node("CanvasLayer/Sfondo/ConvinzioneBracconiere/Label")

# Variabili per i tre bottoni
@onready var button1 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button1")
@onready var label1 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button1/Label1")
@onready var button2 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button2")
@onready var label2 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button2/Label2")
@onready var button3 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button3")
@onready var label3 = get_parent().get_parent().get_node("CanvasLayer/ParlaUI/Bottom/Frasi/Button3/Label3")


var frase_buttons = []

var frasi = [
	{"testo": "Cacciare è sbagliato!", "danno": 20},
	{"testo": "Gli animali meritano di vivere.", "danno": 15},
	{"testo": "La natura è più importante dei soldi!", "danno": 25},
	{"testo": "Sei migliore di così.", "danno": 10},
	{"testo": "Trova un altro lavoro, ti aiuterò.", "danno": 30}
]

func enter():
	parlaUI.visible = true
	if backButton.visible == false:
		backButton.visible = true
		
	button1.visible = true
	button2.visible = true
	button3.visible = true
	
	playerBar.visible = false
	
	backButton.pressed.connect(_on_back_pressed)

	var scelte = frasi.duplicate()
	scelte.shuffle()  # Mescola le frasi
	scelte = scelte.slice(0, 3)  # Seleziona le prime 3 frasi uniche

	# Imposta il testo di ciascun bottone con le frasi
	label1.text = scelte[0]["testo"]
	label2.text = scelte[1]["testo"]
	label3.text = scelte[2]["testo"]

	button1.pressed.connect(_on_frase_pressed.bind(scelte[0]["danno"]))
	button2.pressed.connect(_on_frase_pressed.bind(scelte[1]["danno"]))
	button3.pressed.connect(_on_frase_pressed.bind(scelte[2]["danno"]))

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
		playerBar.visible = false
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
