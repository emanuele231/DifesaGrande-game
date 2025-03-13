# Punteggio_bracconiere.gd (Singleton)
extends Node


var punteggio: int = 0 

func aggiungi_punti(danno: int):
	punteggio += danno
	print("Punteggio attuale:", punteggio)

func rimuovi_punti(danno: int):
	punteggio -= danno
	if punteggio < 0:
		punteggio = 0
	print("Punteggio attuale:", punteggio)

func reset_punteggio():
	punteggio = 0
	print("Punteggio resettato.")
