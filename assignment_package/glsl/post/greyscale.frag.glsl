#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;

void main()
{
    // TODO Homework 5
    vec3 col = texture(u_RenderedTexture, fs_UV).rgb;
    float grey = dot(col, vec3(0.21, 0.72, 0.07));
    vec3 greyCol = vec3(grey, grey, grey);
    // Vignette effect.
    vec2 center = vec2(0.5, 0.5);
    float dist = distance(fs_UV, center);
    float vignette = smoothstep(0.01, 1, dist);
    vec3 finalColor = greyCol * (1 - vignette * 1.2);
    color = finalColor;
}
