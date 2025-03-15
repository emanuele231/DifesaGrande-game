extends Node

var punteggi_massimi : Array = [0, 0, 0, 0] #0 rifiuti, 1 vandalo, 2 bracconiere, 3 incendio In ordine di implementazione

var numero_vittorie : Array = [0, 0, 0, 1] #0 rifiuti, 1 vandalo, 2 bracconiere, 3 incendio

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func set_punteggio(punteggio: int,indice: int)-> void:
	if indice >= 0 and indice < punteggi_massimi.size():
		if punteggio > punteggi_massimi[indice]:
			punteggi_massimi[indice] = punteggio
		else: 
			pass
	else:
		print("Indice non valido.",punteggio,indice)
		
		
func get_punteggio(indice: int) -> int:
	if indice >= 0 and indice < punteggi_massimi.size():
		return punteggi_massimi[indice]
	else:
		print("Indice del minigioco non valido.")
		return -1
	   
func set_vittoria(indice: int) -> void:
	if indice >=0 and indice < numero_vittorie.size():
		numero_vittorie[indice] += 1
	else:
		print("Indice del minigioco non valido.",indice)

func get_numero_vittorie(indice: int) -> int:
	if indice >=0 and indice < numero_vittorie.size():
		return numero_vittorie[indice]
	else:
		print("Indice del minigioco non valido.")
		return -1
		

func tutti_minigiochi_completati() -> bool:
	for vittorie in numero_vittorie:
		if vittorie < 1:
			return false
	return true
