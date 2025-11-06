uniform vec3 spherePosition;

// A shared variable is initialized in the vertex shader and attached to the current vertex being processed,
// such that each vertex is given a shared variable and when passed to the fragment shader,
// these values are interpolated between vertices and across fragments,
// below we can see the shared variable is initialized in the vertex shader using the 'out' classifier
out vec3 viewPosition;
out vec3 worldPosition;
out vec3 interpolatedNormal;


void main() {
    
    // TODO: compute the out variables declared above. Think about which frame(s) each
    // variable should be defined with respect to

    // we take each vertex and 1) put it in terms of world coordinates instead of local to the dragon,
    // 2) get the normal and put it into world coordinates as well, and
    // 3) pass the view position along in world space so we can do math on it in the fragment
    worldPosition = vec3(modelMatrix * vec4(position, 1.0));
    interpolatedNormal = normalize(mat3(modelMatrix) * normal); // 3x3 to avoid translation and scaling, we only want the model matrix to rotate the normal to face the correct direction
    viewPosition = worldPosition;

    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
