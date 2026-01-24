shader_type canvas_item;

// ty smitner :3

uniform ivec2 offset = ivec2(0, 0);
uniform sampler2D eyelid_texture : filter_nearest;
uniform sampler2D mask_texture : filter_nearest;


void fragment() {
	vec2 uv_offset = vec2(offset) * TEXTURE_PIXEL_SIZE;
	vec2 eye_uv = UV - uv_offset;

	vec4 eye_color = texture(TEXTURE, eye_uv);
	vec4 eye_lid_color = texture(eyelid_texture, UV);
	vec4 mask = texture(mask_texture, UV);

	vec4 composite = mix(eye_color, eye_lid_color, eye_lid_color.a);

	composite.a *= (1.0 - round(mask.a));

	COLOR = composite;
}
