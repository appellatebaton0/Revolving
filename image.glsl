// Define PI for angle stuff.
#define PI 3.14159265359

// How many instances of the uv are onscreen.
float repeat = 5.0;

// How spaced out each uv is.
float spacing = 1.5;

// How many rings in each instance.
float rings = 3.0;

// How fast the rings close in on themselves.
float ring_speed = 0.8;

vec4 ring_color_a = vec4(1.0, 0.0, 0.6, 1.0);
vec4 ring_color_b = vec4(0.6, 1.0, 0.6, 1.0);

// The number of vertical and horizontal lines.
vec2 lines = vec2(2.0, 1.6);

// How fast the lines scroll
vec2 line_speed = vec2(0.3, -0.6);

// How fast the lines spin.
float line_spin = -0.3;

vec4 line_color_a = vec4(1.0, 0.0, 0.6, 1.0);
vec4 line_color_b = vec4(0.6, 1.0, 0.6, 1.0);


// Based off the 2D rotation matrix, rotate a vec2 by an angle.
vec2 rotate(vec2 vector, float angle)
{
    return vec2(vector.x * sin(angle) - vector.y * cos(angle), vector.x * cos(angle) + vector.y * sin(angle));
}

vec4 get_background_color(vec2 uv)
{
    bool fill = false;
    uv = rotate(uv - 0.5, iTime * line_spin) + 0.5;

    if (mod(uv.x * lines.x + iTime * line_speed.x, 1.0) > 0.5)
    {
        fill = !fill;
    }

    if (mod(uv.y * lines.y + iTime * line_speed.y, 1.0) > 0.5)
    {
        fill = !fill;
    }

    return  fill ? line_color_a : line_color_b;
}


vec4 get_instance_color(vec2 uv)
{
    vec2 cuv = uv - 0.5;
    float dist = sqrt(pow(cuv.x, 2.0) + pow(cuv.y, 2.0));

    float opacity = 1.- 2. * dist;
    
    if (mod(dist * rings + iTime * ring_speed, 1.0) > 0.5)
    {
        bool color_swap = mod(dist * rings * 2.0 + iTime * ring_speed, 1.0) > 0.5;
        
        return color_ring_color_a : ring_color_b;
    }
    
    return get_background_color(uv);
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Pixel position, from 0 to 1 across the screen.
    vec2 uv = fragCoord / iResolution.xy;

    float angle = iTime + sqrt(pow(uv.x, 2.0) + pow(uv.y, 2.0));
    vec2 offset = vec2(-iMouse.x / iResolution.x, iTime / 10000.0);

    vec2 rot_uv = rotate(uv + offset, angle);

    vec2 new_uv = mod(rot_uv * repeat, 1.) * spacing;

    fragColor = get_instance_color(new_uv);

    if (new_uv.x > 1. || new_uv.y > 1.)
    {
        fragColor = get_background_color(rot_uv);
    }

    fragColor = get_instance_color(uv);
}

