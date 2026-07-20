//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 VHS Color Bleed v1.0

vec4 hook()
{
    vec2 uv = HOOKED_pos;
    vec2 px = 1.0 / HOOKED_size;

    vec4 c0 = HOOKED_tex(uv);

    vec4 c1 = HOOKED_tex(uv - vec2(px.x * 1.0, 0.0));
    vec4 c2 = HOOKED_tex(uv - vec2(px.x * 2.0, 0.0));
    vec4 c3 = HOOKED_tex(uv + vec2(px.x * 1.0, 0.0));
    vec4 c4 = HOOKED_tex(uv + vec2(px.x * 2.0, 0.0));

    vec3 outColor = c0.rgb;

    // Red bleed
    outColor.r =
        c0.r * 0.45 +
        c1.r * 0.25 +
        c2.r * 0.15 +
        c3.r * 0.10 +
        c4.r * 0.05;

    // Blue bleed (enyhébb)
    outColor.b =
        c0.b * 0.65 +
        c1.b * 0.20 +
        c2.b * 0.10 +
        c3.b * 0.05;

    // Green szinte érintetlen
    outColor.g = c0.g;

    return vec4(outColor, c0.a);
}
