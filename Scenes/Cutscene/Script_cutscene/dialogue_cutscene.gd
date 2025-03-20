extends Sprite2D

@onready var label = $CutsceneDialogue
@export var current_index = 0   # Indice che rappresenta la sezione della storia corrente

# Testo storia della cutscene 
var story_dialogue = [
	"[center]La mia storia inizia.. nella natura. L'ho sempre amata. Mi piace osservare le [u][color=#e3a807]podoliche[/color][/u] che pascolano libere, sentire l'odore della terra, il calore del sole sul mio viso" +
	" e il dolce canto degli uccellini.[/center]",
	"[center]A quei tempi, passavo la vita prendendomi cura delle mie podoliche e del mio [u][color=#e3a807]orto[/color][/u]. " +
	"C'era pero' un posto che non avevo mai esplorato.. il Bosco Difesa Grande.[/center]",
	"[center]Un giorno, mentre accudivo le mie polodiche, vidi del fumo salire in cielo.\n" +
	"Era un incendio, e le sue fiamme avanzavano rapidamente.[/center]",
	"[center]Avevo molta paura, ma non potevo perdere tempo.\n\n[font_size=50]Dovevo [u][color=#e3a807]chiamare[/color][/u] i soccorsi![/font_size][/center]",
	"[center]Per fortuna, i [u][color=#e3a807]vigili del fuoco[/color][/u] arrivarono in tempo e, con tanto coraggio, ci salvarono dalle fiamme." +
	" Io e le mie podoliche eravamo al sicuro, ma la mia casa non c'era piu'.[/center]",
	"[center]Qualche giorno dopo, il Sindaco e l'Assessore di Gravina mi chiamarono." + 
	" Erano dispiaciuti per la mia situazione, e mi dissero che l'incendio proveniva dal Bosco Difesa Grande. " +
	"Volevano che sapessi una cosa: il [u][color=#e3a807]Bosco Difesa Grande[/color][/u] non poteva permettersi un altro disastro simile." + 
	" Avevano bisogno di qualcuno che lo proteggesse.[/center]",
	"[center]Mi offrirono una [u][color=#e3a807]casa[/color][/u] all'interno del Bosco " + 
	"dove poter vivere con le mie podoliche, e un compito: proteggere il Bosco dalle minacce![/center]"
]

func _ready():
	label.text = story_dialogue[current_index]

# Quando si preme l'elemento della GUI che permette di andare avanti nella storia, si scorre il testo con l'indice.
func _on_next_pressed():
	if current_index < story_dialogue.size() - 1:
		current_index += 1
		label.text = story_dialogue[current_index]
	else:
		print("Fine cutscene")
		# Azioni dopo la fine della cutscene
