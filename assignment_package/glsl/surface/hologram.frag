#version 330
uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;

in vec2 fs_UV;
in vec4 fs_Pos;
in vec3 fs_Nor;
in vec4 fs_LightVec;

layout(location = 0) out vec4 out_Col;

float rand(vec2 n) {
    return fract(sin(dot(n, vec2(12.9898, 4.1414))) * 43758.5453);
}

void main()
{
    vec2 uv = fs_UV;
    // Distortion effect
    float distortion = sin(u_Time * 0.01 + uv.y) * 0.05;
    uv.x += distortion;
    vec4 baseColor = texture(u_Texture, uv);

    // Scanline effect
    float scanline = sin(fs_UV.y * 300.0) * 0.05;
    baseColor.rgb += scanline;

    // Flickering effect
    float flicker = rand(vec2(u_Time * 0.001, uv.y)) * 0.2 - 0.1;
    baseColor.rgb += flicker;
    baseColor *= vec4(0.5, 0.7, 1.0, 1.0);
    out_Col = baseColor;
}
