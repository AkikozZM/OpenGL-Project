#version 150

uniform ivec2 u_Dimensions;
uniform int u_Time;

in vec2 fs_UV;
in vec4 fs_LightVec;
out vec3 color;

uniform sampler2D u_RenderedTexture;

vec2 random2(vec2 st) {
    st = vec2(dot(st, vec2(127.1, 311.7)),
              dot(st, vec2(269.5, 183.3)));
    return -1.0 + 2.0 * fract(sin(st) * 43758.5453123);
}


float WorleyNoise(vec2 uv) {
    uv *= 10.0; // Now the space is 10x10 instead of 1x1. Change this to any number you want.
    vec2 uvInt = floor(uv);
    vec2 uvFract = fract(uv);
    float minDist = 1.0; // Minimum distance initialized to max.
    for(int y = -1; y <= 1; ++y) {
        for(int x = -1; x <= 1; ++x) {
            vec2 neighbor = vec2(float(x), float(y)); // Direction in which neighbor cell lies
            vec2 point = random2(uvInt + neighbor); // Get the Voronoi centerpoint for the neighboring cell
            vec2 diff = neighbor + point - uvFract; // Distance between fragment coord and neighbor’s Voronoi point
            float dist = length(diff);
            minDist = min(minDist, dist);
        }
    }
    return minDist;
}

void main()
{
    // TODO Homework 5

    // Calculate the Worley noise value at this UV and its neighbors
    float currentNoise = WorleyNoise(fs_UV);
    float noiseRight = WorleyNoise(fs_UV + vec2(1.0 / u_Dimensions.x, 0.0)) * cos(u_Time * -0.001);
    float noiseUp = WorleyNoise(fs_UV + vec2(0.0, 1.0 / u_Dimensions.y));

    vec2 gradient = vec2(noiseRight - currentNoise, noiseUp - currentNoise);
    vec2 warpedUV = fs_UV + gradient * sin(u_Time * 0.01);

    vec3 curColor = texture(u_RenderedTexture, warpedUV).rgb;

    float factor = 0.5 * sin(u_Time * 0.01) + 0.5;
    float radius = 2;
    vec3 direction = normalize(fs_LightVec.xyz);
    vec3 sphericalPos = direction * radius;
    vec3 deformedPos = mix(fs_LightVec.xyz, sphericalPos, factor);

    color = curColor * deformedPos;
}
