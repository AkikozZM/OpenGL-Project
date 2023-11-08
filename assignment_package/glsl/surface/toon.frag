#version 330
uniform sampler2D u_Texture; // The texture to be read from by this shader
uniform int u_Time;

in vec2 fs_UV;
in vec4 fs_Pos;
in vec3 fs_Nor;
in vec4 fs_LightVec;

layout(location = 0) out vec3 out_Col;

void main(void)
{
    vec3 baseColor = texture(u_Texture, fs_UV).rgb;
    float diffuse = max(dot(normalize(fs_Nor), normalize(fs_LightVec.xyz)), 0.0);

    if (diffuse > 0.5) {
        diffuse = 1.0;
    }
    else if (diffuse > 0.2) {
        diffuse = 0.5;
    }
    else {
        diffuse = 0.1;
    }

    out_Col = baseColor * diffuse;
}
