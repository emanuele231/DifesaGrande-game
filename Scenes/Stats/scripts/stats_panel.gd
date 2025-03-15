extends Control

# Bottoni
@onready var bottoni = $Label/Bottoni
@onready var bottone_record = $Label/Bottoni/Record
@onready var bottone_obiettivi = $Label/Bottoni/Obiettivi
@onready var bottone_indietro = $Label/Indietro

# Aree da mostrare/nascondere
@onready var area_record = $Label/AreaRecord
@onready var area_obiettivi = $Label/AreaObiettivi

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	# Connette i bottoni alle funzioni
	bottone_record.pressed.connect(mostra_area_record)
	bottone_obiettivi.pressed.connect(mostra_area_obiettivi)
	bottone_indietro.pressed.connect(gestisci_indietro)


# Mostra l'area dei record e nasconde il resto
func mostra_area_record():
	bottoni.visible = false
	area_record.visible = true
	area_obiettivi.visible = false
	bottone_indietro.visible = true

# Mostra l'area degli obiettivi e nasconde il resto
func mostra_area_obiettivi():
	bottoni.visible = false
	area_record.visible = false
	area_obiettivi.visible = true
	bottone_indietro.visible = true

# Gestisce il bottone "Indietro"
func gestisci_indietro():
	if area_record.visible or area_obiettivi.visible:
		# Torna alla schermata principale con i bottoni
		area_record.visible = false
		area_obiettivi.visible = false
		bottoni.visible = true
	else:
		# Se siamo già nei bottoni, chiude la scena
			queue_free()
