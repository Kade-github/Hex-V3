#pragma header

uniform sampler2D lutInner;
uniform sampler2D lutRim;

uniform sampler2D lutInnerTo;
uniform sampler2D lutRimTo;
uniform float uRimGainTo;
uniform float uBlend;

uniform float uFrameLeft;
uniform float uFrameTop;
uniform float uFrameRight;
uniform float uFrameBottom;

uniform float uSheetWidth;
uniform float uSheetHeight;

uniform float uStrength;

uniform float uRimGain;
uniform float uRimAmount;
uniform float uRimSpread;
uniform float uRimCurve;
uniform float uGlowCurve;
uniform float uGlowAmount;
uniform float uTaps;

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

float alphaAt(vec2 uv) {
    if (uv.x < uFrameLeft || uv.y < uFrameTop || uv.x > uFrameRight || uv.y > uFrameBottom)
        return 0.0;
    return texture2D(bitmap, uv).a;
}

float phase(vec2 p) {
    vec3 q = fract(vec3(p.xyx) * 0.1031);
    q += dot(q, q.yzx + 33.33);
    return fract((q.x + q.y) * q.z);
}

float edgeDepth(vec2 uv, vec2 px, float reach) {
    float cover = 0.0;
    float wsum = 0.0;
    float a0 = phase(gl_FragCoord.xy) * 6.2831853;
    for (int k = 0; k < 32; k++) {
        if (float(k) >= uTaps) break;

        float fk = float(k) + 0.5;
        float t = fk / uTaps;
        float w = 1.0 - t * 0.75;
        float ang = a0 + fk * 2.3999632;
        cover += alphaAt(uv + vec2(cos(ang), sin(ang)) * (t * reach) * px) * w;
        wsum += w;
    }
    return cover / wsum;
}

float rimWeight(float depth, float gain) {
    float d = clamp(1.0 - depth, 0.0, 1.0);
    float rim = pow(d, uRimCurve) * gain;
    float glow = pow(d, uGlowCurve) * uGlowAmount * gain;
    return clamp(max(rim, glow), 0.0, 1.0) * uRimAmount;
}

vec4 texelAt(vec2 uv) {
    return flixel_texture2D(bitmap, uv);
}

void main() {
    vec2 px = 1.0 / vec2(uSheetWidth, uSheetHeight);

    vec2 pos = openfl_TextureCoordv * vec2(uSheetWidth, uSheetHeight) - 0.5;
    vec2 base = floor(pos);
    vec2 f = pos - base;

    vec4 c00 = texelAt((base + vec2(0.5, 0.5)) * px);
    vec4 c10 = texelAt((base + vec2(1.5, 0.5)) * px);
    vec4 c01 = texelAt((base + vec2(0.5, 1.5)) * px);
    vec4 c11 = texelAt((base + vec2(1.5, 1.5)) * px);

    vec4 color = mix(mix(c00, c10, f.x), mix(c01, c11, f.x), f.y);

    if (color.a <= 0.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    }

    float depth = edgeDepth(openfl_TextureCoordv, px, 12.0 * uRimSpread);
    float wFrom = rimWeight(depth, uRimGain);

    vec3 straight = clamp(color.rgb / color.a, 0.0, 1.0);

    vec3 lit = look(lutInner, straight);
    if (wFrom > 0.0)
        lit = mix(lit, look(lutRim, straight), wFrom);

    if (uBlend > 0.0) {
        float wTo = rimWeight(depth, uRimGainTo);
        vec3 to = look(lutInnerTo, straight);
        if (wTo > 0.0)
            to = mix(to, look(lutRimTo, straight), wTo);
        lit = mix(lit, to, uBlend);
    }

    gl_FragColor = vec4(mix(straight, lit, uStrength) * color.a, color.a);
}
