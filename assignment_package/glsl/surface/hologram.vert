#version 150

uniform mat4 u_Model;
uniform mat3 u_ModelInvTr;
uniform mat4 u_View;
uniform mat4 u_Proj;

in vec4 vs_Pos;
in vec4 vs_Nor;
in vec2 vs_UV;

out vec2 fs_UV;
out vec3 fs_Nor;
out vec4 fs_LightVec;
out vec4 fs_Pos;

uniform vec3 u_Cam;

void main()
{
    fs_UV = vs_UV;
    fs_Nor = normalize(u_ModelInvTr * vs_Nor.xyz);
    vec4 modelposition = u_Model * vs_Pos;
    fs_Pos = modelposition;

    fs_LightVec = vec4(u_Cam, 1.0) - modelposition;

    gl_Position = u_Proj * u_View * modelposition;
}
