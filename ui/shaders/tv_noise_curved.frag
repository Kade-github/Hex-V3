#pragma header

uniform float iTime;
uniform float scanIntensity;

uniform float crtCurvature;

float rand(float seed) {
    return fract(sin(dot(vec2(seed), vec2(12.9898, 78.233))) * 43758.5453);
}

float rowRand(float row, float salt) {
    return rand(row * 17.0 + salt + floor(iTime * 12.0));
}

vec2 crtCurve(vec2 uv) {
    vec2 centered = uv * 2.0 - 1.0;

    // Barrel distortion: push corners outward
    vec2 offset = centered.yx * centered.yx * crtCurvature;
    centered += centered * offset;

    return centered * 0.5 + 0.5;
}

float crtVignette(vec2 uv) {
    vec2 centered = uv * 2.0 - 1.0;
    float dist = dot(centered, centered);
    return clamp(1.0 - dist * 0.6, 0.0, 1.0);
}

vec2 displace(vec2 co, float seed, float seed2) {
    vec2 shift = vec2(0.0);
    float glitch = step(0.88, rand(seed));
    float rowGlitch = step(0.82, rand(floor(co.y * 48.0) + seed2));

    if (glitch > 0.0) {
        shift += vec2((0.5 - rand(seed2 + 13.0)) * 0.18, (0.5 - rand(seed + 7.0)) * 0.01);
    }

    if (rowGlitch > 0.0) {
        shift.x += (0.5 - rand(seed2 * 1.7)) * 0.12;
        shift.y += (0.5 - rand(seed * 1.3)) * 0.006;
    }

    return shift;
}

vec4 interlace(vec2 co, vec4 col) {
    vec2 pixelCoord = co * openfl_TextureSize;
    float remainder = pixelCoord.y - 3.0 * floor(pixelCoord.y / 3.0);
    float movingLine = smoothstep(0.22, 0.0, abs(fract(co.y * 7.0 - iTime * 0.35) - 0.5));
    float flicker = 0.75 + 0.25 * sin(iTime * 18.0 + co.x * 14.0);
    
    if (abs(remainder) < 0.1) {
        return col * ((sin(iTime * 4.0) * 0.12) + 0.7) + (rand(iTime + co.x * 11.0) * 0.08);
    }
    return col * flicker + vec4(movingLine * 0.04);
}

void main() {
    vec2 uv = crtCurve(openfl_TextureCoordv);

    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 1.0);
        return;
    }

    float row = floor(uv.y * openfl_TextureSize.y * 0.5);
    float burst = step(0.92 - scanIntensity * 0.12, rowRand(row, 3.7));
    float tear = (0.5 - rowRand(row, 11.3)) * burst * (0.08 + scanIntensity * 0.08);
    float wobble = (0.5 - rand(floor(iTime * 24.0) + row * 0.25)) * 0.01 * scanIntensity;

    uv.x += tear;
    uv.y += wobble;
    uv += displace(uv, row + iTime * 17.0, row * 1.7) * scanIntensity;

    vec2 rDisplace = vec2(0.0);
    vec2 gDisplace = vec2(0.0);
    vec2 bDisplace = vec2(0.0);
    
    rDisplace.x += 0.010 * (0.5 - rand(iTime * 37.0 * uv.y));
    gDisplace.x += 0.014 * (0.5 - rand(iTime * 41.0 * uv.y));
    bDisplace.x += 0.006 * (0.5 - rand(iTime * 53.0 * uv.y));

    rDisplace.y += 0.001 * (0.5 - rand(iTime * 37.0 * uv.x));
    gDisplace.y += 0.001 * (0.5 - rand(iTime * 41.0 * uv.x));
    bDisplace.y += 0.001 * (0.5 - rand(iTime * 53.0 * uv.x));
    
    vec4 texColor = texture2D(bitmap, uv);
    float rcolor = texture2D(bitmap, uv + rDisplace).r;
    float gcolor = texture2D(bitmap, uv + gDisplace).g;
    float bcolor = texture2D(bitmap, uv + bDisplace).b;
    
    vec4 finalColor = interlace(uv, vec4(rcolor, gcolor, bcolor, texColor.a));
    
    float fragCoordY = uv.y * openfl_TextureSize.y;
    float scanline = 0.5 + 0.5 * sin((fragCoordY * 0.85) + iTime * 22.0 + sin(uv.x * 6.0 + iTime * 2.5) * 3.0);
    float movingLine = smoothstep(0.18, 0.0, abs(fract(uv.y * 8.0 - iTime * 0.45) - 0.5));
    float staticNoise = (rand(floor(fragCoordY) + iTime * 120.0) - 0.5) * 0.12 * scanIntensity;

    finalColor.rgb = mix(finalColor.rgb, vec3(0.0), scanline * 0.65);
    finalColor.rgb += vec3(staticNoise);
    finalColor.rgb += vec3(0.08, 0.12, 0.1) * movingLine * scanIntensity;
    
    // Multiply by vignette to darken curved screen edges
    finalColor.rgb *= crtVignette(uv);
    
    gl_FragColor = finalColor;
}
