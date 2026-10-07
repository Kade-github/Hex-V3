#pragma header

uniform float uSize;
uniform float uDirections;
uniform float uQuality;

void main()
{
    vec2 uv = openfl_TextureCoordv;
    float pi2 = 6.28318530718;
    vec2 radius = vec2(uSize) * fwidth(uv);

    vec4 colour = flixel_texture2D(bitmap, uv);
    if (uSize <= 0.0)
    {
        gl_FragColor = colour;
        return;
    }

    for (float d = 0.0; d < pi2; d += pi2 / uDirections)
    {
        for (float i = 1.0 / uQuality; i <= 1.0; i += 1.0 / uQuality)
        {
            colour += flixel_texture2D(bitmap, uv + vec2(cos(d), sin(d)) * radius * i);
        }
    }

    colour /= uQuality * uDirections + 1.0;
    gl_FragColor = colour;
}