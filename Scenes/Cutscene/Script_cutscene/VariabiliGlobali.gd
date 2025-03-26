extends Node

# Cutscene iniziale
var click_count = 0  # Variabile click counter per la cutscene iniziale

# Variabili per la gestione del minigioco dell'incendio
var error_count = 0  # Variabile per contare gli errori
var error_limit = 5  # Numero massimo di errori
var combo = 0 # Per il moltiplicatore di combo
var score = 0

var acqua_pressed = false

var first_minigameincendio_play = true
var game_over_called = false

# Cattura dei nodi AudioStreamPlayer2D per la gestione dei sound effects
