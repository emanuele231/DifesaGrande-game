extends Control

# Area Obiettivi
@onready var medaglia1 = $ScrollContainer/VBoxContainer/Obiettivo1/medaglia
@onready var medaglia2 = $ScrollContainer/VBoxContainer/Obiettivo2/medaglia
@onready var medaglia3 = $ScrollContainer/VBoxContainer/Obiettivo3/medaglia
@onready var medaglia4 = $ScrollContainer/VBoxContainer/Obiettivo4/medaglia
@onready var medaglia5 = $ScrollContainer/VBoxContainer/Obiettivo5/medaglia
@onready var medaglia6 = $ScrollContainer/VBoxContainer/Obiettivo6/medaglia

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	verifica_obiettivo1()
	verifica_obiettivo2()
	verifica_obiettivo3()
	verifica_obiettivo4()
	verifica_obiettivo5()
	verifica_obiettivo6()

#Completa ogni minigoco almeno una volta
func verifica_obiettivo1() -> void:
	if SingletonStats.tutti_minigiochi_completati() == true:
		medaglia1.visible = true
		print("medaglia 1")

#Completa 3 volte minigioco rifiuti
func verifica_obiettivo2() -> void:
	if SingletonStats.get_numero_vittorie(0) > 3:
		medaglia2.visible = true
		print("medaglia 2")
	
#Completa 3 volte minigioco bracconiere
func verifica_obiettivo3() -> void:
	if SingletonStats.get_numero_vittorie(2) > 3:
		medaglia3.visible = true
		print("medaglia 3")
		

#Completa 3 volte minigioco vandalo
func verifica_obiettivo4() -> void:
	if SingletonStats.get_numero_vittorie(1) > 3:
		medaglia4.visible = true
		print("medaglia 4")
		

#sblocca una stella di grado di protezione del bosco
func verifica_obiettivo5() -> void:
	if SingletonStats.tutti_minigiochi_completati() == true:
		medaglia5.visible = true
		print("medaglia 5")

#Raggiungi il punteggio massimo nel minigioco del bracconiere
func verifica_obiettivo6() -> void:
	if SingletonStats.get_punteggio(2) == 100:
		medaglia6.visible = true
		print("medaglia 6")
	
