shader_type canvas_item;

uniform float hue: hint_range(-1.0, 1.0, 0.01) = 0.0;
uniform float brightness: hint_range(-1.0, 1.0, 0.01) = 0.0;
uniform float contrast: hint_range(-10.0, 10.0, 0.01) = 1.0;
uniform float saturation: hint_range(-10.0, 10.0, 0.01) = 1.0;

uniform float brightness_limit: hint_range(-1.0, 1.0, 0.01) = 1.0;

mat4 brightness_matrix(float b) {
	return mat4(
			vec4(1, 0, 0, 0),
			vec4(0, 1, 0, 0),
			vec4(0, 0, 1, 0),
			vec4(b, b, b, 1)
	);
}

mat4 contrast_matrix(float c) {
	float t = (1.0 - c) / 2.0;
	return mat4(
			vec4(c, 0, 0, 0),
			vec4(0, c, 0, 0),
			vec4(0, 0, c, 0),
			vec4(t, t, t, 1)
	);
}

mat4 saturation_matrix(float s) {
	vec3 luminance = vec3(0.3086, 0.6094, 0.0820);
	float sr = (1.0 - s) * luminance.r;
	float sb = (1.0 - s) * luminance.g;
	float sg = (1.0 - s) * luminance.b;

	return mat4(
			vec4(sr + s, sr, sr, 0),
			vec4(sg, sg + s, sg, 0),
			vec4(sb, sb, sb + s, 0),
			vec4(0, 0, 0, 1)
	);
}

vec3 to_hsv(vec3 rgb) {
	vec3 c = rgb;
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.xzy), step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 to_rgb(vec3 hsv) {
	vec3 c = hsv;
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec3 color_hsv = to_hsv(color.rgb);
	color_hsv.x = mod((color_hsv.x + hue * 0.5), 1.0);
	color.rgb = to_rgb(color_hsv);
	mat4 matrix =
			brightness_matrix(min(brightness, brightness_limit))
			* contrast_matrix(contrast)
			* saturation_matrix(saturation);
	COLOR = matrix * color;
}