//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 VHS Blur v1.0

#define HORIZONTAL_BLUR 1.2
#define CENTER_WEIGHT 0.50
#define SIDE_WEIGHT 0.25

vec4 hook()
{
    vec2 uv = HOOKED_pos;
    vec2 px = 1.0 / HOOKED_size;

    vec4 left =
        HOOKED_tex(
            uv - vec2(px.x * HORIZONTAL_BLUR, 0.0));

    vec4 center =
        HOOKED_tex(uv);

    vec4 right =
        HOOKED_tex(
            uv + vec2(px.x * HORIZONTAL_BLUR, 0.0));

    vec4 color =
          left   * SIDE_WEIGHT
        + center * CENTER_WEIGHT
        + right  * SIDE_WEIGHT;

    return color;
}
