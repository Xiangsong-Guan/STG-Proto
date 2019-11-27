shader_type canvas_item;

uniform vec4 colorful: hint_color = vec4(.3, .5, .9, 1.);

float circle(in float _radius, in vec2 _uv) {
	return 1. - smoothstep(_radius-(_radius*.01), _radius+(_radius*.3), dot(_uv-vec2(.5),_uv-vec2(.5))*4.);
}

void fragment() {
	float radius = .2;
	vec4 col = vec4(colorful.rgb, circle(radius, UV));
	float shine = smoothstep(radius-.9, 1.2, dot(UV-vec2(.5),UV-vec2(.5))*4.);
	
	float r = 3.5 + (sin(TIME / 1.5) * 2.);
	float scale = 25.;
	vec2 ps = TEXTURE_PIXEL_SIZE / scale;
	vec4 glow = col;
	
	col += (1. - shine) * smoothstep(radius-.05, radius, dot(UV-vec2(.5),UV-vec2(.5))*4.);
	
	glow += circle(radius, UV + vec2(-r, -r) * ps) * col;
	glow += circle(radius, UV + vec2(-r, 0.0) * ps) * col;
	glow += circle(radius, UV + vec2(-r, r) * ps) * col;
	glow += circle(radius, UV + vec2(0.0, -r) * ps) * col;
	glow += circle(radius, UV + vec2(0.0, r) * ps) * col;
	glow += circle(radius, UV + vec2(r, -r) * ps) * col;
	glow += circle(radius, UV + vec2(r, 0.0) * ps) * col;
	glow += circle(radius, UV + vec2(r, r) * ps) * col;

	r *= 2.0;
	glow += circle(radius, UV + vec2(-r, -r) * ps) * col;
	glow += circle(radius, UV + vec2(-r, 0.0) * ps) * col;
	glow += circle(radius, UV + vec2(-r, r) * ps) * col;
	glow += circle(radius, UV + vec2(0.0, -r) * ps) * col;
	glow += circle(radius, UV + vec2(0.0, r) * ps) * col;
	glow += circle(radius, UV + vec2(r, -r) * ps) * col;
	glow += circle(radius, UV + vec2(r, 0.0) * ps) * col;
	glow += circle(radius, UV + vec2(r, r) * ps) * col;

	glow /= 16.;
	glow *= .7;

	COLOR = glow + col;
}