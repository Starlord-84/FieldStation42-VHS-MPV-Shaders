//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 VHS Resolution v1.0

// Belső "VHS" felbontás
#define VHS_WIDTH 640.0
#define VHS_HEIGHT 480.0

vec4 hook()
{
    vec2 uv = HOOKED_pos;

    // Pixelméret a "VHS" felbontáshoz
    vec2 pixel = vec2(1.0 / VHS_WIDTH, 1.0 / VHS_HEIGHT);

    // Pixelrácsra kerekítés
    uv = floor(uv / pixel) * pixel + pixel * 0.5;

    return HOOKED_tex(uv);
}
