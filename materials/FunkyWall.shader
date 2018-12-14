shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise_tex;

void fragment () {
	vec2 offset = vec2(0.5, TIME * 0.1);
	
	float blue = texture(noise_tex, UV + offset).b + texture(noise_tex, UV - offset).b;
	
	uint ublue = floatBitsToUint(blue);
	ublue = ublue << uint(9);
	ALBEDO = vec3(0.3, 0.3, uintBitsToFloat(ublue));
	ALPHA = blue * 0.1;
}