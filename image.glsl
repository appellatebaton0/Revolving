// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

float repeat = 20.0;

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Pixel position, from 0 to 1 across the screen.
    vec2 uv = fragCoord / iResolution.xy;

    // A colour that shifts over time.
    vec3 col = 0.5 + 0.5 * cos(iTime + uv.xyx + vec3(0.0, 2.0, 4.0));

    vec2 new_uv = mod(uv * repeat, 2.) * 1.2;

    fragColor = vec4(new_uv.x, new_uv.y, 0.0, 1.0);

    if (new_uv.x > 1. || new_uv.y > 1.)
    {
        fragColor = vec4(0.0);
    }
}
