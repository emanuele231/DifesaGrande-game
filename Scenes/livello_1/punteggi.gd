extends Control


	
func _ready():
	$carta_rimasta.z_index = 3
	$plastica_rimasta.z_index = 3
	$indifferenziato_rimasto.z_index = 3
	$capienza_sacco.z_index = 3
	$organico_rimasto.z_index = 3

func _process(delta):
	var p_position = global_position
	var min_limit = Vector2(-352, -464) 
	var max_limit = Vector2(1040, 1232) 

	p_position.x = clamp(p_position.x, min_limit.x, max_limit.x)
	p_position.y = clamp(p_position.y, min_limit.y, max_limit.y)
	global_position = p_position

		
	
	
