#pragma header

uniform float uMix;
uniform float uTime;
uniform float uIntensity;
uniform vec3 uColor1;
uniform vec3 uColor2;

vec2 hash( vec2 p )
{
	p = vec2( dot(p,vec2(127.1,311.7)), dot(p,vec2(269.5,183.3)) );
	return -1.0 + 2.0*fract(sin(p)*43758.5453123);
}

float noise( in vec2 p )
{
    const float K1 = 0.366025404; // (sqrt(3)-1)/2;
    const float K2 = 0.211324865; // (3-sqrt(3))/6;

	vec2  i = floor( p + (p.x+p.y)*K1 );
    vec2  a = p - i + (i.x+i.y)*K2;
    float m = step(a.y,a.x);
    vec2  o = vec2(m,1.0-m);
    vec2  b = a - o + K2;
	vec2  c = a - 1.0 + 2.0*K2;
    vec3  h = max( 0.5-vec3(dot(a,a), dot(b,b), dot(c,c) ), 0.0 );
	vec3  n = h*h*h*h*vec3( dot(a,hash(i+0.0)), dot(b,hash(i+o)), dot(c,hash(i+1.0)));
    return dot( n, vec3(70.0) );
}

void main() {
    // if original color is transparent, skip
    vec4 tex0 = flixel_texture2D(bitmap, openfl_TextureCoordv);
    if (tex0.a <= 0.01) {
        gl_FragColor = tex0;
        return;
    }

    vec2 fragCoord = openfl_TextureCoordv * openfl_TextureSize;

    vec2 uv = (fragCoord - 0.5 * openfl_TextureSize.xy) / openfl_TextureSize.y;

    // Apply noise with time animation
    uv = vec2(noise(uv + uTime * 0.1), noise(uv + 10.0));

    // Create the pattern
    float d = uv.x - uv.y;
    d *= uIntensity;
    d = sin(d);
    d = d * 0.5 + 0.5;
    d = 1.0 - d;

    float threshold = 0.01;
    d = smoothstep(0.5 - threshold, 0.5 + threshold, d);

    // Final color mixing
    vec3 col = mix(uColor1, uColor2, d);

    gl_FragColor = vec4(col, uMix);
}
