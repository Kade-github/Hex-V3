#pragma header

uniform float uGray;
uniform float uInvert;

vec4 eyePick(vec3 dir) {
    float across = atan(dir.x, -dir.z);
    float down = asin(clamp(dir.y, -1.0, 1.0)) * uRound.y + uRound.w;

    vec4 here = texture2D(uTexture, vec2(across * uRound.x + uRound.z, down));

    float meet = smoothstep(2.6, 3.14159265, abs(across)) * 0.5;
    if (meet > 0.0) {
        float other = across - sign(across) * 6.28318531;
        vec4 there = texture2D(uTexture, vec2(other * uRound.x + uRound.z, down));
        here = mix(here, there, meet);
    }

    return here;
}

void main(void) {
    vec4 texel = eyePick(normalize(vLocal));

    float much = clamp(uGray, 0.0, 1.0);
    float over = clamp(uInvert, 0.0, 1.0);

    if (much > 0.0 || over > 0.0) texel.a = 1.0;

    vec4 came = nfShade(texel);

    if (much <= 0.0 && over <= 0.0) {
        gl_FragColor = came;
        return;
    }

    float held = max(came.a, 0.0001);
    vec3 lit = came.rgb / held;

    float gray = dot(lit, vec3(0.299, 0.587, 0.114));
    lit = mix(lit, vec3(gray), much);

    lit = mix(lit, vec3(1.0) - lit, over);

    gl_FragColor = vec4(lit * held, came.a);
}
