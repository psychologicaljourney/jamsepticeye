shader_type canvas_item;

instance uniform vec4 hit_color : source_color = vec4(1, 1, 1, 1);
instance uniform bool hit = false;

void fragment() {
	vec4 col = texture(TEXTURE, UV);
	vec3 final_col = hit ? hit_color.rgb : col.rgb; // if hit use the hit color otherwise use the original sprite color
	COLOR = vec4(final_col, col.a);
}
