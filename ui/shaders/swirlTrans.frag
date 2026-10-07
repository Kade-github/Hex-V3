// Adapted from Shadertoy https://www.shadertoy.com/view/wtG3WV
// erevan 2020-01-24

#pragma header

uniform float uTime;

// Shadertoy functions
float sdCircle(vec2 p, vec2 center, float r) {
    return length(p - center) - r;
}

float rand(float x) {
    return fract(sin(x) * 43758.5453);
}

float triangle(float x) {
    return abs(1.0 - mod(abs(x), 2.0)) * 2.0 - 1.0;
}

float theClamp(float value, float minVal, float maxVal) {
    if (value < minVal) return minVal;
    if (value > maxVal) return maxVal;
    return value;
}

void main() {
    float time = floor(uTime * 16.0) / 16.0;
    vec2 uv = openfl_TextureCoordv;
    
    // Get screen resolution equivalent
    vec2 iResolution = openfl_TextureSize;
    vec2 fragCoord = uv * iResolution;
    
    
    // Distorted coordinates
    vec2 p = (2.0 * fragCoord - iResolution.xy) / iResolution.y;

    vec2 upperRightCenter = vec2(0.9, -0.5); // Upper right in normalized coords

    p += vec2(
        triangle(uv.y * rand(time * 0.1)) * rand(time * 2.1) * 0.004,
        triangle(uv.x * rand(time * 0.1)) * rand(time * 3.1) * 0.004
    );

    // Circle distance function as transition mask
    float d = sdCircle(p, upperRightCenter, -0.1);

    float c = uTime * 0.5;
    float mask = (11.0 * cos(35.0 * d - d * pow(d, 0.1)) +
                  11.0 * d * cos(abs(c * 1.3) + 0.8) * 11.0);
    
    mask = theClamp(mask * 0.05 + 0.5, 0.0, 1.0);

    // Sample the main texture
    vec4 tex0 = flixel_texture2D(bitmap, openfl_TextureCoordv);
    
    // Create transparent color for transition
    vec4 transparent = vec4(0.0, 0.0, 0.0, 0.0);

    // Transition between texture and transparency using mask
    vec4 color = mix(tex0, transparent, mask);

    gl_FragColor = color;
}