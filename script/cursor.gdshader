shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;

void fragment() {
	COLOR.rgb = 1.0 - textureLod(screen_texture, SCREEN_UV, 0.0).rgb;
	COLOR.a = texture(TEXTURE, UV).a;
	
}
