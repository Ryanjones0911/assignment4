// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 spherePosition;

// A shared variable is initialized in the vertex shader and attached to the current vertex being processed,
// such that each vertex is given a shared variable and when passed to the fragment shader,
// these values are interpolated between vertices and across fragments,
// below we can see the shared variable is initialized in the vertex shader using the 'out' classifier
out vec3 interpolatedNormal;
out vec3 lightDirection;
out vec3 vertexPosition;

void main() {
    // TODO:
    // HINT: We need vertexPosition in local object frame, lightDirection in VCS.
    // And don't forget to transform the normal to an appropriate frame!

    interpolatedNormal = normalize(mat3(modelMatrix) * normal);

    //defaults to local coordinates, no need to manipulate
    vertexPosition = position; 
    lightDirection = normalize(spherePosition - vec3(modelMatrix * vec4(position, 1.0)));

    
    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
