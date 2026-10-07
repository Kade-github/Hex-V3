#pragma header

uniform float uTilesX;
uniform float uTilesY;

uniform float uTileW;
uniform float uTileH;

uniform float uScroll;

const float STRIP_LEFT = -725.0;
const float STRIP_WIDE = 1536.0;

const float STRIP_TOP = -375.0;
const float REPEAT = 720.0;

float mirror(float x) {
	float m = mod(x, 2.0);
	return m > 1.0 ? 2.0 - m : m;
}

void main() {
	vec2 tiled = fract(openfl_TextureCoordv * vec2(uTilesX, uTilesY));
	vec2 here = (tiled - 0.5) * vec2(uTileW, uTileH);

	float across = (here.x - STRIP_LEFT) / STRIP_WIDE;
	float down = (here.y - STRIP_TOP) / REPEAT;
	float slid = uScroll / REPEAT;

	vec4 left = flixel_texture2D(bitmap, vec2(across, mirror(down - slid)));
	vec4 right = flixel_texture2D(bitmap, vec2(1.0 - across, 1.0 - mirror(down + slid)));
	
	gl_FragColor = right + left * (1.0 - right.a);
}
