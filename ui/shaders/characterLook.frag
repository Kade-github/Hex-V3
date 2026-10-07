#pragma header

uniform sampler2D lutFrom;
uniform sampler2D lutTo;

uniform float uFromOn;
uniform float uToOn;

uniform float uBlend;

vec3 cell(sampler2D lut, vec3 i) {
    vec2 tile = vec2(mod(i.b, 8.0), floor(i.b / 8.0)) * 64.0;
    return texture2D(lut, (tile + i.rg + 0.5) / 512.0).rgb;
}

vec3 look(sampler2D lut, vec3 c) {
    vec3 x = c * 63.0;
    vec3 i = min(floor(x), vec3(62.0));
    vec3 f = x - i;

    vec3 c000 = cell(lut, i);
    vec3 c100 = cell(lut, i + vec3(1.0, 0.0, 0.0));
    vec3 c010 = cell(lut, i + vec3(0.0, 1.0, 0.0));
    vec3 c110 = cell(lut, i + vec3(1.0, 1.0, 0.0));
    vec3 c001 = cell(lut, i + vec3(0.0, 0.0, 1.0));
    vec3 c101 = cell(lut, i + vec3(1.0, 0.0, 1.0));
    vec3 c011 = cell(lut, i + vec3(0.0, 1.0, 1.0));
    vec3 c111 = cell(lut, i + vec3(1.0, 1.0, 1.0));

    vec3 low = mix(mix(c000, c100, f.r), mix(c010, c110, f.r), f.g);
    vec3 high = mix(mix(c001, c101, f.r), mix(c011, c111, f.r), f.g);
    return mix(low, high, f.b);
}

vec4 graded(vec2 uv) {
    vec4 color = flixel_texture2D(bitmap, uv);
    if (color.a <= 0.0)
        return color;

    vec3 straight = clamp(color.rgb / color.a, 0.0, 1.0);
    vec3 from = uFromOn > 0.5 ? look(lutFrom, straight) : straight;
    vec3 to = uToOn > 0.5 ? look(lutTo, straight) : straight;
    return vec4(mix(from, to, uBlend) * color.a, color.a);
}

void main() {
    vec2 pos = openfl_TextureCoordv * openfl_TextureSize - 0.5;
    vec2 base = floor(pos);
    vec2 f = pos - base;
    vec2 texel = 1.0 / openfl_TextureSize;

    vec4 c00 = graded((base + vec2(0.5, 0.5)) * texel);
    vec4 c10 = graded((base + vec2(1.5, 0.5)) * texel);
    vec4 c01 = graded((base + vec2(0.5, 1.5)) * texel);
    vec4 c11 = graded((base + vec2(1.5, 1.5)) * texel);

    gl_FragColor = mix(mix(c00, c10, f.x), mix(c01, c11, f.x), f.y);
}
