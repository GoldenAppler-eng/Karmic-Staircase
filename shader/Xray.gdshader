shader_type canvas_item;

uniform sampler2D player_viewport: filter_nearest;
uniform vec4 tint : source_color;

void fragment() {
	vec4 player = texture(player_viewport, SCREEN_UV);
	vec4 self_color = texture(TEXTURE, UV);
	
	COLOR = (1.0 - player.a) * self_color + (player.a) * vec4(tint.rgb, self_color.a);
}
