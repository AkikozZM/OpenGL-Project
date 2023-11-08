#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

uniform int u_Time;

in vec4 vs_Pos;
in vec4 vs_Nor;

out vec3 fs_Pos;
out vec3 fs_Nor;
out vec4 fs_LightVec;

uniform vec3 u_Cam;

void main()
{
    // TODO Homework 4
    fs_Nor = normalize(u_ModelInvTr * vec3(vs_Nor));
    // Add time-based deformation
    // Oscillate factor between 0 and 1
    float factor = 0.5 * sin(u_Time * 0.01) + 0.5;
    float radius = 3.0;
    vec3 direction = normalize(vs_Pos.xyz);
    vec3 sphericalPos = direction * radius;
    vec3 deformedPos = mix(vs_Pos.xyz, sphericalPos, factor);

    vec4 modelposition = u_Model * vec4(deformedPos, 1.0);
    fs_Pos = vec3(modelposition);
    gl_Position = u_Proj * u_View * modelposition;
    fs_LightVec = vec4(u_Cam, 1.0) - modelposition;
}
