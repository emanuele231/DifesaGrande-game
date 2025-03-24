extends Node

# Cutscene iniziale
var click_count = 0  # Variabile click counter per la cutscene iniziale

# Variabili per la gestione del minigioco dell'incendio
var error_count = 0  # Variabile per contare gli errori
var error_limit = 5  # Numero massimo di errori
var active_notes = {} # Dizionario per tenere traccia delle note attive con i tasti associati