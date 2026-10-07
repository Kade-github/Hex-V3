#pragma header

uniform float iTime;
uniform float scanIntensity;

float rand(float seed) {
    return fract(sin(dot(vec2(seed), vec2(12.9898, 78.233))) * 43758.5453);
}

vec2 displace(vec2 co, float seed, float seed2) {
    vec2 shift = vec2(0.0);
    if (rand(seed) > 0.5) {
        shift += 0.1 * vec2(2.0 * (0.5 - rand(seed2)));
    }
    if (rand(seed2) > 0.6) {
        if (co.y > 0.5) {
            shift.x *= rand(seed2 * seed);
        }
    }
    return shift;
}

vec4 interlace(vec2 co, vec4 col) {
    // Convert to pixel coordinates and check if y is divisible by 3
    vec2 pixelCoord = co * openfl_TextureSize;
    float remainder = pixelCoord.y - 3.0 * floor(pixelCoord.y / 3.0);
    
    if (abs(remainder) < 0.1) {
        return col * ((sin(iTime * 4.0) * 0.1) + 0.75) + (rand(iTime) * 0.05);
    }
    return col;
}

void main() {
    vec2 uv = openfl_TextureCoordv;
    
    vec2 rDisplace = vec2(0.0);
    vec2 gDisplace = vec2(0.0);
    vec2 bDisplace = vec2(0.0);
    
    // Random displacement for RGB channels
    rDisplace.x += 0.005 * (0.5 - rand(iTime * 37.0 * uv.y));
    gDisplace.x += 0.007 * (0.5 - rand(iTime * 41.0 * uv.y));
    bDisplace.x += 0.0011 * (0.5 - rand(iTime * 53.0 * uv.y));

    rDisplace.y += 0.001 * (0.5 - rand(iTime * 37.0 * uv.x));
    gDisplace.y += 0.001 * (0.5 - rand(iTime * 41.0 * uv.x));
    bDisplace.y += 0.001 * (0.5 - rand(iTime * 53.0 * uv.x));
    
    // Get RGB channels with displacement
    vec4 texColor = texture2D(bitmap, uv);
    float rcolor = texture2D(bitmap, uv + rDisplace).r;
    float gcolor = texture2D(bitmap, uv + gDisplace).g;
    float bcolor = texture2D(bitmap, uv + bDisplace).b;
    
    // Apply interlacing to displaced colors
    vec4 finalColor = interlace(uv, vec4(rcolor, gcolor, bcolor, texColor.a));
    
    // Apply scanline effect
    float fragCoordY = uv.y * openfl_TextureSize.y;
    float scanline = abs(sin(fragCoordY) * 0.5 * 0.5);
    finalColor.rgb = mix(finalColor.rgb, vec3(0.0), scanline);
    
    gl_FragColor = finalColor;
}