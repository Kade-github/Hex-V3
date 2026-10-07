#pragma header

uniform float percent;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    vec4 originalColor = flixel_texture2D(bitmap, uv);
    vec4 black = vec4(0.0, 0.0, 0.0, originalColor.a);

    float p = clamp(percent, 0.0, 2.0);

    float front = mix(-1.0, 2.0, p) + (1.0 - uv.y);

    if (p <= 1.0)
    {
        float covered = step(uv.x, front);
        gl_FragColor = mix(originalColor, black, covered);
    }
    else
    {
        float t = p - 1.0;
        float trail = mix(-1.0, 2.0, t) + (1.0 - uv.y);
        float revealed = step(uv.x, trail);
        gl_FragColor = mix(black, originalColor, revealed);
    }
}