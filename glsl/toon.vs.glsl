// The uniform variable is set up in the javascript code and the same for all vertices
uniform vec3 spherePosition;

// A shared variable is initialized in the vertex shader and attached to the current vertex being processed,
// such that each vertex is given a shared variable and when passed to the fragment shader,
// these values are interpolated between vertices and across fragments,
// below we can see the shared variable is initialized in the vertex shader using the 'out' classifier
out vec3 interpolatedNormal;
out vec3 lightDirection;
out float fresnel; // NOTE: this refers to the dot product of view direction and normal

void main() {
    // TODO:
    // Compute vertex position, light direction in VCS, and transform the normal to
    // an appropriate frame. Then determine if a vertex lies on the silhouette edge 
    // of the model or not and set `fresnel` appropriately.

    // same as in part A1, just taking the local coordiates and transforming them to world coordinates, as well as figuring out
    // what the light direction is in world coordinates. Don't think we need it but rather have it
    vec3 worldPosition = vec3(modelMatrix * vec4(position, 1.0));
    interpolatedNormal = normalize(mat3(modelMatrix) * normal);
    lightDirection = normalize(spherePosition - worldPosition);


    vec3 viewDir = normalize(-worldPosition);

    // for figuring out the border for the black outline. We use abs() to make sure the back isnt just perma-black
    fresnel = abs(dot(interpolatedNormal, viewDir));


    gl_Position = projectionMatrix * viewMatrix * modelMatrix * vec4(position, 1.0);
}
