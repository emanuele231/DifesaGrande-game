extends Control


var dialog_01_sequence := [
	"Sei stato fantastico!!",
	"Adesso il bar Quercus è stato ripulito",
	"Benvenuto ora nella ZONA DELLE LEPRI",
	"Come vedi, è pieno di lepri che gironzolano qua e la",
	"Ma qualcosa le sta minacciando",
	"Trova il punto esclamativo ( !!! ) bianco sulla strada",
	"scopri che cosa minaccia queste creature!"
] 
# Called when the node enters the scene tree for the first time.
func _ready():
	$".".hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	pass # Replace with function body.
