shader_type canvas_item;

uniform vec2 brush_position;
uniform float brush_size;
uniform sampler2D mask_texture;

void fragment() {
    vec4 mask = texture(mask_texture, UV);  // La texture della maschera

    // Calcola la distanza tra la posizione del pennello e il pixel corrente
    float dist = distance(UV, brush_position);

    // Se la distanza è minore della dimensione del pennello, modifica la trasparenza
    if (dist < brush_size) {
        mask.a = 0.0;  // Rende trasparente l'area sotto il pennello
    }

    COLOR = vec4(mask.rgb, mask.a);  // Imposta il colore finale
}
