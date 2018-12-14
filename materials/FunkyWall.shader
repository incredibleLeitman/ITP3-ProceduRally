shader_type spatial;
render_mode cull_disabled;

uniform sampler2D noise_tex;
uniform vec3 color_multiplier = vec3(0.0, 0.0, 1.0);

uniform float uv_scale = 0.3;
uniform bool mix_move = true;

uniform int shifter = 9;

void fragment () {
	vec2 offset = vec2(0.25, TIME * 0.1);
	
	float blue = texture(noise_tex, UV * uv_scale + offset).b;
	if (mix_move) {
		blue += texture(noise_tex, UV * uv_scale - offset).b;
	} else {
		blue += texture(noise_tex, UV * uv_scale - offset).b * 0.4;
	}
	
	uint ublue = floatBitsToUint(blue);
	ublue = ublue << uint(shifter);
	ALBEDO = uintBitsToFloat(ublue) * color_multiplier;
	ALPHA = blue * 0.1;
}