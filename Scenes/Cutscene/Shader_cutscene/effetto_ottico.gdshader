shader_type canvas_item;

uniform sampler2D mask_texture;
uniform vec2 brush_position;
uniform float brush_size;

void fragment() {
    vec4 mask = texture(TEXTURE, UV);

    float dist = distance(UV, brush_position);

    if (dist < brush_size) {
        mask.a = 0.0; // Rendi trasparente la zona dipinta
    }

    COLOR = vec4(1.0, 1.0, 1.0, mask.a); // Mantiene il bianco finché non viene "dipinto"
}