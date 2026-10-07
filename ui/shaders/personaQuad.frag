#pragma header

// Uniforms for the 4 corner points (in screen pixel coordinates)
uniform vec2 uPos1;
uniform vec2 uPos2;
uniform vec2 uPos3;
uniform vec2 uPos4;

uniform float uMix;
uniform bool uEnabled;
uniform float jitterAmount;
uniform float uTime;

uniform vec3 uColor1;
uniform vec3 uColor2;
uniform vec3 uColor3;

// Better hash function for noise
float hash(float n) {
    return fract(sin(n) * 43758.5453);
}

// Improved noise function with proper time animation
float noise(vec2 p) {
    vec2 ip = floor(p);
    vec2 fp = fract(p);
    fp = fp * fp * (3.0 - 2.0 * fp);
    
    float n = ip.x + ip.y * 57.0;
    return mix(mix(hash(n + 0.0), hash(n + 1.0), fp.x),
               mix(hash(n + 57.0), hash(n + 58.0), fp.x), fp.y);
}

// Animated noise for jitter - use screen-space coordinates for consistent animation
vec2 animatedNoise(vec2 pixelCoord, float seed) {
    float time = uTime * 2.0;
    // Use pixel coordinates directly for consistent noise regardless of UV scale
    float x = noise(vec2(pixelCoord.x * 0.01 + time, pixelCoord.y * 0.01 + seed));
    float y = noise(vec2(pixelCoord.x * 0.01 + time + 100.0, pixelCoord.y * 0.01 + seed + 200.0));
    return vec2(x, y) - 0.5;
}

// Check if point is inside triangle using barycentric coordinates
bool pointInTriangle(vec2 p, vec2 a, vec2 b, vec2 c) {
    vec2 v0 = c - a;
    vec2 v1 = b - a;
    vec2 v2 = p - a;

    float dot00 = dot(v0, v0);
    float dot01 = dot(v0, v1);
    float dot02 = dot(v0, v2);
    float dot11 = dot(v1, v1);
    float dot12 = dot(v1, v2);

    float invDenom = 1.0 / (dot00 * dot11 - dot01 * dot01);
    float u = (dot11 * dot02 - dot01 * dot12) * invDenom;
    float v = (dot00 * dot12 - dot01 * dot02) * invDenom;

    return (u >= 0.0) && (v >= 0.0) && (u + v <= 1.0);
}

// Better inside quad check
bool insideQuad(vec2 p, vec2 a, vec2 b, vec2 c, vec2 d) {
    bool inTriangle1 = pointInTriangle(p, a, b, c);
    bool inTriangle2 = pointInTriangle(p, a, c, d);
    return inTriangle1 || inTriangle2;
}

void main() {
    vec2 uv = openfl_TextureCoordv;
    vec4 originalColor = flixel_texture2D(bitmap, uv);

    if (!uEnabled || uMix <= 0.0) {
        gl_FragColor = originalColor;
        return;
    }

    vec3 bg = originalColor.rgb;

    // Convert screen pixel coordinates to UV space for quad positions
    vec2 point1 = uPos1 / openfl_TextureSize.xy;
    vec2 point2 = uPos2 / openfl_TextureSize.xy;
    vec2 point3 = uPos3 / openfl_TextureSize.xy;
    vec2 point4 = uPos4 / openfl_TextureSize.xy;

    // Calculate jitter using original pixel coordinates for consistent animation
    vec2 jitterOffset1 = (animatedNoise(uPos1, 0.0) * jitterAmount);
    vec2 jitterOffset2 = (animatedNoise(uPos2, 100.0) * jitterAmount);
    vec2 jitterOffset3 = (animatedNoise(uPos3, 200.0) * jitterAmount);
    vec2 jitterOffset4 = (animatedNoise(uPos4, 300.0) * jitterAmount);

    vec2 jitterPoint1 = point1 + jitterOffset1;
    vec2 jitterPoint2 = point2 + jitterOffset2;
    vec2 jitterPoint3 = point3 + jitterOffset3;
    vec2 jitterPoint4 = point4 + jitterOffset4;

    // Check if current pixel is inside the defined quad
    bool inside = insideQuad(uv, jitterPoint1, jitterPoint2, jitterPoint3, jitterPoint4);

    // Improved color detection using luminance
    float luminance = dot(bg, vec3(0.299, 0.587, 0.114));
    
    // Classify pixels based on brightness
    float isWhite = smoothstep(0.7, 0.9, luminance);
    float isBlack = 1.0 - smoothstep(0.1, 0.3, luminance);
    float isOther = 1.0 - min(1.0, isWhite + isBlack);
    
    vec3 blueColor = vec3(0.043, 0.0, 0.976);
    vec3 cyanColor = vec3(0.725, 1.0, 0.984);
    vec3 orangeColor = vec3(1.0, 0.310, 0.0);
    
    // White -> blue, black -> cyan, anything else -> orange
    vec3 recolor = isWhite * uColor1 + isBlack * uColor2 + isOther * uColor3;
    
    // Mix between original and recolor based on inside condition
    gl_FragColor = vec4(mix(originalColor.rgb, recolor, float(inside) * uMix), originalColor.a);
}