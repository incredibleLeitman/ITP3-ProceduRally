shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise_tex;
uniform vec3 color_multiplier = vec3(0.0, 0.0, 1.0);

void fragment () {
	vec2 offset = vec2(0.25, TIME * 0.1);
	
	float blue = texture(noise_tex, UV + offset).b + texture(noise_tex, UV - offset).b;
	
	uint ublue = floatBitsToUint(blue);
	ublue = ublue << uint(9);
	ALBEDO = uintBitsToFloat(ublue) * color_multiplier;
	ALPHA = blue * 0.1;
}