#pragma header

vec3 snapToGrid(vec3 color) {
    vec3 c = color * 255.0;
    
    float r = c.r;
    float snapR;
    if(r < 21.0) snapR = 0.0;
    else if(r < 63.0) snapR = 42.0;
    else if(r < 90.0) snapR = 85.0;
    else if(r < 138.0) snapR = 127.0;
    else if(r < 175.0) snapR = 170.0;
    else if(r < 234.0) snapR = 212.0;
    else snapR = 255.0;

    float g = c.g;
    float snapG;
    if(g < 15.0) snapG = 0.0;
    else if(g < 31.0) snapG = 31.0;
    else if(g < 47.0) snapG = 63.0;
    else if(g < 79.0) snapG = 95.0;
    else if(g < 111.0) snapG = 127.0;
    else if(g < 143.0) snapG = 159.0;
    else if(g < 175.0) snapG = 191.0;
    else if(g < 234.0) snapG = 223.0;
    else snapG = 255.0;

    float b = c.b;
    float snapB;
    if(b < 42.0) snapB = 0.0;
    else if(b < 127.0) snapB = 85.0;
    else if(b < 212.0) snapB = 170.0;
    else snapB = 255.0;

    return vec3(snapR, snapG, snapB) / 255.0;
}

void main() {
    float maxSize = 512.0;
    vec2 pixelSize = vec2(1.0 / maxSize, 1.0 / maxSize);
    vec2 uv = floor(openfl_TextureCoordv / pixelSize) * pixelSize;

    vec4 color = texture2D(bitmap, uv);
    color.rgb *= vec3 (1.0, 0.75, 1.0); // apply tint BEFORE snapping so it affects the snap result
    color.rgb = snapToGrid(color.rgb);

    gl_FragColor = color;
}