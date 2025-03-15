extends Node

var punteggi_massimi: Array = [0, 0, 0, 0] # 0 - rifiuti, 1 - vandalo, 2 - bracconiere, 3 - incendio
var numero_vittorie: Array = [0, 0, 0, 1] # 0 - rifiuti, 1 - vandalo, 2 - bracconiere, 3 - incendio

# Inizializzazione
func _ready() -> void:
	print("Singleton di statistiche caricato.")

# Imposta il punteggio record per un minigioco
func set_punteggio(punteggio: int, indice: int) -> void:
	if _indice_valido(indice):
		if punteggio > punteggi_massimi[indice]:
			punteggi_massimi[indice] = punteggio
			print("Nuovo punteggio per il minigioco", indice, ":", punteggio)
	else:
		print("Errore: indice non valido -", indice)

# Restituisce il punteggio record per un minigioco
func get_punteggio(indice: int) -> int:
	if _indice_valido(indice):
		return punteggi_massimi[indice]
	print("Errore: indice del minigioco non valido -", indice)
	return -1

# Incrementa il numero di vittorie per un minigioco
func set_vittoria(indice: int) -> void:
	if _indice_valido(indice):
		numero_vittorie[indice] += 1
		print("Vittorie per minigioco", indice, ":", numero_vittorie[indice])
	else:
		print("Errore: indice non valido -", indice)
	stampa() 

# Restituisce il numero di vittorie per un minigioco
func get_numero_vittorie(indice: int) -> int:
	if _indice_valido(indice):
		return numero_vittorie[indice]
	print("Errore: indice del minigioco non valido -", indice)
	return -1

# Controlla se tutti i minigiochi sono stati completati almeno una volta
func tutti_minigiochi_completati() -> bool:
	stampa() 
	for vittorie in numero_vittorie:
		if vittorie < 1:
			return false
	return true

func _indice_valido(indice: int) -> bool:
	return indice >= 0 and indice < numero_vittorie.size()
	

# Stampa i dati degli array per debug
func stampa() -> void:
	print("\n=== DEBUG ===")
	print("Punteggi :", punteggi_massimi)
	print("Numero vittorie:", numero_vittorie)
	print("=========================\n")
