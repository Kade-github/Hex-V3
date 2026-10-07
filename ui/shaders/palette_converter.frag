#pragma header

// color palette (colors to replace from)
uniform vec3 color1;
uniform vec3 color2;
uniform vec3 color3;
uniform vec3 color4;
uniform vec3 color5;
uniform vec3 color6;

// tColor palette (colors to replace to)
uniform vec3 tColor1;
uniform vec3 tColor2;
uniform vec3 tColor3;
uniform vec3 tColor4;
uniform vec3 tColor5;
uniform vec3 tColor6;

void main() {
    vec2 uv = openfl_TextureCoordv;
    vec4 originalColor = flixel_texture2D(bitmap, uv);

    float vibrancy = 1.35;

    if (originalColor.a == 0.0) {
        gl_FragColor = vec4(0.0, 0.0, 0.0, 0.0);
        return;
    }
    
    vec3 colorPalette[6];
    colorPalette[0] = color1;
    colorPalette[1] = color2;
    colorPalette[2] = color3;
    colorPalette[3] = color4;
    colorPalette[4] = color5;
    colorPalette[5] = color6;
    
    vec3 tColorPalette[6];
    tColorPalette[0] = tColor1;
    tColorPalette[1] = tColor2;
    tColorPalette[2] = tColor3;
    tColorPalette[3] = tColor4;
    tColorPalette[4] = tColor5;
    tColorPalette[5] = tColor6;
    
    vec3 colorSum = vec3(0.0);
    float weightSum = 0.0;
    
    for (int i = 0; i < 6; i++) {
        vec3 diff = originalColor.rgb - colorPalette[i];
        float dist = dot(diff, diff);
        
        float weight = 1.0 / (dist + 0.1); // +0.1 to avoid division by zero
        
        colorSum += tColorPalette[i] * weight;
        weightSum += weight;
    }
    
    vec3 weightedTarget = colorSum / weightSum;
    
    float minDist = 9999.0;
    for (int i = 0; i < 6; i++) {
        vec3 diff = originalColor.rgb - colorPalette[i];
        float dist = dot(diff, diff);
        minDist = min(minDist, dist);
    }
    
    float blendAmount = 1.0 - smoothstep(0.0, 0.4, minDist);
    vec3 finalColor = mix(originalColor.rgb, weightedTarget, blendAmount);
    
    vec3 vibrantColor = finalColor;
    float luminance = dot(vibrantColor, vec3(0.299, 0.587, 0.114));
    vibrantColor = mix(vec3(luminance), vibrantColor, vibrancy);
    
    vibrantColor = (vibrantColor - 0.5) * (1.0 + (vibrancy - 1.0) * 0.3) + 0.5;
    
    vibrantColor = clamp(vibrantColor, 0.0, 1.0);
    
    vibrantColor = pow(vibrantColor, vec3(1.0 / (1.0 + (vibrancy - 1.0) * 0.2)));
    
    vibrantColor = clamp(vibrantColor, 0.0, 1.0);
    
    gl_FragColor = vec4(vibrantColor, originalColor.a);
}