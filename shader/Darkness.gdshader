shader_type canvas_item;

uniform float min_alpha : hint_range(0.0, 1.0, 0.1);
uniform float max_alpha : hint_range(0.0, 1.0, 0.1);

void fragment() {
	float alpha = (max_alpha - min_alpha) * (1.0 - UV.x) + min_alpha;
	
	COLOR.a = alpha;
}
