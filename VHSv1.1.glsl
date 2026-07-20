//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 VHS Color Shift v1.1

vec4 hook()
{
    vec2 uv = HOOKED_pos;
    vec2 px = 1.0 / HOOKED_size;

    // Alap chroma késés
    float baseShift = 1.8;

    // Soronként enyhe analóg instabilitás
    float lineJitter =
        sin(uv.y * 850.0) * 0.25 +
        sin(uv.y * 147.0) * 0.12;

    // Nagyon lassú drift
    float drift =
        sin(uv.y * 12.0 + uv.x * 2.0) * 0.10;

    float redShift  = (baseShift + lineJitter + drift) * px.x;
    float blueShift = -(baseShift * 0.65 + lineJitter * 0.8) * px.x;

    // Függőleges chroma instabilitás
    float vertical =
        sin(uv.y * 35.0) * 0.15 * px.y;

    vec4 center = HOOKED_tex(uv);

    vec4 red =
        HOOKED_tex(uv + vec2(redShift, vertical));

    vec4 blue =
        HOOKED_tex(uv + vec2(blueShift, -vertical));

    vec3 color;

    color.r = red.r;
    color.g = center.g;
    color.b = blue.b;

    // Enyhe VHS keverés
    color = mix(color, center.rgb, 0.12);

    return vec4(color, center.a);
}
