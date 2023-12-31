#version 150
// passthrough.vert.glsl:
// A vertex shader that simply passes along vertex data
// to the fragment shader without operating on it in any way.

in vec4 vs_Pos;
in vec2 vs_UV;

out vec2 fs_UV;

out vec4 fs_LightVec;
uniform vec3 u_Cam;

void main()
{
    fs_UV = vs_UV;
    gl_Position = vs_Pos;
    fs_LightVec = vec4(u_Cam, 1.0) - vs_Pos;
}
