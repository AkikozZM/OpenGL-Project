#version 150

in vec2 fs_UV;

out vec3 color;

uniform sampler2D u_RenderedTexture;
uniform int u_Time;
uniform ivec2 u_Dimensions;

void main()
{
    // TODO Homework 5
    // Define Sobel Kernels
    mat3 sobelHori = mat3(3.0, 10.0, 3.0,
                          0.0, 0.0, 0.0,
                          -3.0, -10.0, -3.0);
    mat3 sobelVert = mat3(3.0, 0.0, -3.0,
                          10.0, 0.0, -10.0,
                          3.0, 0.0, -3.0);
    vec3 horzGrad = vec3(0.0);
    vec3 vertGrad = vec3(0.0);
    vec2 step = vec2(1.0 / u_Dimensions.x, 1.0 / u_Dimensions.y);
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            // Get the color of the neighboring pixel
            vec3 curColor = texture(u_RenderedTexture, fs_UV + vec2(x, y) * step).rgb;
            // Multiply the color by the Sobel kernel value and accumulate
            horzGrad += curColor * sobelHori[y + 1][x + 1];
            vertGrad += curColor * sobelVert[y + 1][x + 1];
        }
    }
    vec3 gradMagnitude = sqrt(horzGrad * horzGrad + vertGrad * vertGrad);
    color = gradMagnitude;
}
