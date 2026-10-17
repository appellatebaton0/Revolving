// Welcome! This is a Shadertoy-style shader.
// mainImage runs once for each pixel, every frame.
// Try changing a number, then watch the preview on the right.

#define PI 3.14159265359

// How many instances of the uv are onscreen.
float repeat = 10.0;

// How spaced out each uv is.
float spacing = 1.3;

// Based off the 2D rotation matrix, rotate a vec2 by an angle.
vec2 rotate(vec2 vector, float angle)
{
    return vec2(vector.x * sin(angle) - vector.y * cos(angle), vector.x * cos(angle) + vector.y * sin(angle));
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Pixel position, from 0 to 1 across the screen.
    vec2 uv = fragCoord / iResolution.xy;

    float angle = iTime + sqrt(pow(uv.x, 2.0) + pow(uv.y, 2.0));
    vec2 offset = vec2(-iMouse.xy)/ iResolution.xy;

    vec2 rot_uv = rotate(uv + offset, angle);

    vec2 new_uv = mod(rot_uv * repeat, 1.) * spacing;

    //float o = 0.4;
    //new_uv = rotate(new_uv - vec2(o), angle) + vec2(o);

    fragColor = vec4(new_uv.x, new_uv.y, 0.0, 1.0);

    if (new_uv.x > 1. || new_uv.y > 1.)
    {
        fragColor = vec4(1.);//rot_uv.x, rot_uv.y, 0.0, 1.0);
    }
}
