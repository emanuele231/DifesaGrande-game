extends AnimationPlayer

func _ready():
	scale_animations()

func scale_animations():
	var viewport_size = get_viewport().size
	var scale_factor = viewport_size.x / 1152.0  # 1152 è la dimensione base

	for anim_name in get_animation_list():
		var anim = get_animation(anim_name)
		if anim:
			for track_id in range(anim.get_track_count()):
				if anim.track_get_type(track_id) == Animation.TYPE_VALUE:  
					var path = anim.track_get_path(track_id).get_concatenated_names()
					
					# Verifica se la traccia riguarda la posizione
					if path.ends_with("position"):
						for key_id in range(anim.track_get_key_count(track_id)):
							var key_time = anim.track_get_key_time(track_id, key_id)
							var key_value = anim.track_get_key_value(track_id, key_id) * scale_factor
							anim.track_set_key_value(track_id, key_id, key_value)

	print("Animazioni scalate correttamente per il viewport:", viewport_size)
