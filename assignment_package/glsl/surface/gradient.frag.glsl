#version 330

uniform sampler2D u_Texture; // The texture to be read from by this shader

in vec3 fs_Nor;
in vec4 fs_LightVec;

layout(location = 0) out vec3 out_Col;

void main()
{
    // TODO Homework 4
    out_Col = vec3(0, 0, 0);
    float t = dot(normalize(fs_Nor), normalize(fs_LightVec.xyz));

    // Constants for the iridescence
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.0, 0.33, 0.67);

    // Compute the gradient color
    vec3 gradient = a + b * cos(2.0 * 3.14 * (c * t + d));

    out_Col = gradient;
}
