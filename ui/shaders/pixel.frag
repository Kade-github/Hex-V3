#pragma header

uniform float pixelSize;

void main() {
    vec2 pixelCoord = openfl_TextureCoordv * openfl_TextureSize;
    vec2 pixelizedCoord = floor(pixelCoord / pixelSize) * pixelSize;
    vec2 uv = pixelizedCoord / openfl_TextureSize;
    gl_FragColor = flixel_texture2D(bitmap, uv);
}