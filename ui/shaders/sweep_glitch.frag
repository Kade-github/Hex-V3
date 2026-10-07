#pragma header

uniform float percent;
uniform float iTime;

float hash12(vec2 p)
{
	vec3 p3 = fract(vec3(p.xyx) * 0.1031);
	p3 += dot(p3, p3.yzx + 33.33);
	return fract((p3.x + p3.y) * p3.z);
}

vec4 glitchSquares(vec2 uv, float time)
{
	float cellCount = 26.0 + 5.0 * sin(time * 0.8);
	vec2 g = uv * cellCount;
	vec2 cell = floor(g);
	vec2 local = fract(g) - 0.5;

	float h = hash12(cell);
	float h2 = hash12(cell + 19.7);

	float pulse = 0.5 + 0.5 * sin(time * (2.0 + h * 3.0) + h * 11.0);
	float size = mix(0.18, 0.47, pulse);

	local += (vec2(h, h2) - 0.5) * 0.06 * sin(time * 3.0 + h * 9.0);

	float square = 1.0 - step(size, max(abs(local.x), abs(local.y)));
	float active = step(0.22, hash12(cell + floor(time * 10.0)));
	float mask = square * active;

	vec3 a = vec3(0.08, 0.95, 1.00);
	vec3 b = vec3(1.00, 0.25, 0.82);
	vec3 c = vec3(0.95, 1.00, 0.22);

	float c1 = 0.5 + 0.5 * sin(time * 2.4 + h * 12.0);
	float c2 = 0.5 + 0.5 * sin(time * 1.8 + h2 * 15.0 + 1.3);
	vec3 col = mix(a, b, c1);
	col = mix(col, c, c2 * 0.6);
	col *= 0.75 + 0.5 * (0.5 + 0.5 * sin(time * 8.0 + h * 30.0));

	float scan = 0.9 + 0.1 * sin((uv.y * openfl_TextureSize.y) * 0.5 + time * 6.0);
	col *= scan;

	return vec4(col, mask);
}

void main()
{
	vec2 uv = openfl_TextureCoordv;
	vec4 originalColor = flixel_texture2D(bitmap, uv);

	float p = clamp(percent, 0.0, 2.0);
	vec4 glitch = glitchSquares(uv, iTime);

	vec3 glitchBase = vec3(0.02, 0.02, 0.03);
	vec3 glitchFill = mix(glitchBase, glitch.rgb, glitch.a);
	vec4 glitchColor = vec4(glitchFill, originalColor.a);

	float front = mix(-1.0, 2.0, p) + (1.0 - uv.y);

	if (p <= 1.0)
	{
		float covered = step(uv.x, front);
		gl_FragColor = mix(originalColor, glitchColor, covered);
	}
	else
	{
		float t = p - 1.0;
		float trail = mix(-1.0, 2.0, t) + (1.0 - uv.y);
		float revealed = step(uv.x, trail);
		gl_FragColor = mix(glitchColor, originalColor, revealed);
	}
}
