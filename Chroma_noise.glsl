//!HOOK MAIN
//!BIND HOOKED
//!DESC FieldStation42 RF Chroma Generator v1.3

#define INTENSITY 0.035
#define BLOCK_SIZE   35.0
#define BLOCK_HEIGHT 3.0
#define SPEED 2.5

float hash(vec2 p)
{
    return fract(sin(dot(p, vec2(127.1,311.7))) * 43758.5453123);
}

vec4 hook()
{
    vec2 uv = HOOKED_pos;
    vec4 color = HOOKED_tex(uv);

    float x = floor(uv.x * HOOKED_size.x / BLOCK_SIZE);
    float y = floor(uv.y * HOOKED_size.y / BLOCK_HEIGHT);

    // A sor nem mozog!
    // Csak ugyanazon blokkok színe változik.
    float t = mod(float(frame), 2048.0) * SPEED;

    float seed1 = mod(t * 13.0, 4096.0);
    float seed2 = mod(t * 17.0, 4096.0);

    float selector = hash(vec2(x, y + seed1));
    float strength = (hash(vec2(x + 31.0, y + seed2)) * 2.0 - 1.0) * INTENSITY;

    vec3 overlay = vec3(0.0);

    if(selector < 0.333)
    {
        overlay.r = strength * 0.55;
    }
    else if(selector < 0.666)
    {
        overlay.g = strength * 0.65;
    }
    else
    {
        overlay.b = strength * 0.90;
    }

    // Világos képen kevésbé látszik
    float luma = dot(color.rgb, vec3(0.299,0.587,0.114));
    overlay *= mix(1.0, 0.25, luma);

    color.rgb += overlay;

    return color;
}
