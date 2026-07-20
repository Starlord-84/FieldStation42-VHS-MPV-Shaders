//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 VHS Tracking v1.0

vec4 hook()
{
    vec2 uv = HOOKED_pos;
    vec2 px = 1.0 / HOOKED_size;

    vec2 sampleUV = uv;

    // Ritkán aktiválódik (~0.8% esély/frame)
    if (random > 0.9995)
    {
        // Tracking sáv
        float band = fract(frame * 0.017);

        if (abs(uv.y - band) < 0.035)
        {
            float offset =
                sin((uv.y - band) * 180.0) *
                8.0 * px.x;

            sampleUV.x += offset;
        }
    }

    vec4 col = HOOKED_tex(sampleUV);

    // Enyhe fényerő villanás
    if (random > 0.9997)
        col.rgb *= 1.08;

    return col;
}
