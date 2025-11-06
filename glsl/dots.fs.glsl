// HINT: Don't forget to define the uniforms here after you pass them in in A3.js

uniform float ticks;

// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 lightDirection;
in vec3 vertexPosition;

void main() {
    // TODO:
    // HINT: First, as you've already done in the Toon fragment shader, compute the light
    // intensity of the current fragment by determining the cosine angle between the surface
    // normal and the light vector. Next, pick any two colors, blend them based on light
    // intensity to give the 3D model some color and depth. Also make the color change wrt tick.
    // Next, implement rolling dots using the mod function, tick and discard.

    float lightIntensity = abs(dot(interpolatedNormal, lightDirection));

    //these colors are completely arbitrary, can be changed to anything
    vec3 baseColor = mix(vec3(0.0, 0.0, 1.0), vec3(0.0, 1.0, 1.0), lightIntensity) * sin(ticks * 0.9);

    //dots (this block is explained in depth in the README)
    vec3 dotGrid = mod(vertexPosition * 20.0 + vec3(0, ticks, 0.0), 1.0);
    vec3 centered = dotGrid - 0.5;
    float distance = length(centered.xy);
    if (distance < 0.2) {
        discard;
    }

    // HINT: Set final rendered colour
    gl_FragColor = vec4(baseColor, 1.0);
}
