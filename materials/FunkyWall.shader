shader_type spatial;

uniform sampler2D noise_tex;
uniform vec3 color_multiplier = vec3(0.0, 0.0, 1.0);

uniform float uv_scale = 0.3;
uniform bool mix_move = true;

uniform int shifter = 9;
uniform float alpha_mult = 0.1;
uniform float speed_mult = 0.1;

void fragment () {
	vec2 offset = vec2(0.25, TIME * speed_mult);
	
	float blue = texture(noise_tex, UV * uv_scale + offset).b;
	if (mix_move) {
		blue += texture(noise_tex, UV * uv_scale - offset).b;
	} else {
		blue += texture(noise_tex, UV * uv_scale - offset).b * 0.4;
	}
	
	uint ublue = floatBitsToUint(blue);
	ublue = ublue << uint(shifter);
	ALBEDO = uintBitsToFloat(ublue) * color_multiplier;
	ALPHA = blue * alpha_mult;
}