#pragma header

// The invert blend mode inverts each pixel's color.

uniform float uIntensity;

void main() {
	// Get the texture to apply to.
	vec4 color = flixel_texture2D(bitmap, openfl_TextureCoordv);

    // Invert the color based on intensity.
    if (color.a > 0.0)
        color.rgb = mix(color.rgb, 1.0 - color.rgb, uIntensity);

    // Output the final color.
	gl_FragColor = color;
}