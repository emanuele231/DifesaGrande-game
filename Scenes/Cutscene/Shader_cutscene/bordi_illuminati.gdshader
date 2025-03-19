shader_type canvas_item;

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
	float thickness = 0.09;
	float smoothness = 0.05;

    // Controlla la trasparenza del pixel
    float alpha = base_color.a;

    // Espande i bordi rilevando i pixel semi-trasparenti
    float border = texture(TEXTURE, UV + vec2(thickness, 0)).a +
                   texture(TEXTURE, UV - vec2(thickness, 0)).a +
                   texture(TEXTURE, UV + vec2(0, thickness)).a +
                   texture(TEXTURE, UV - vec2(0, thickness)).a;

    if (border > 0.0 && alpha == 0.0) {
        // Bordi arrotondati
        float edge = smoothstep(0.0, smoothness, border);
        COLOR = vec4(0.53, 0.70, 0.0, edge); // Giallo (RGB: 1.0, 1.0, 0.0)
    } else {
        COLOR = base_color; // Mantiene il colore originale
    }
}
