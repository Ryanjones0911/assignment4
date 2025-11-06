
uniform vec3 ambientColor;
uniform float kAmbient;

uniform vec3 diffuseColor;
uniform float kDiffuse;

uniform vec3 specularColor;
uniform float kSpecular;
uniform float shininess;

uniform mat4 modelMatrix;

uniform vec3 spherePosition;

// The value of our shared variable is given as the interpolation between normals computed in the vertex shader
// below we can see the shared variable we passed from the vertex shader using the 'in' classifier
in vec3 interpolatedNormal;
in vec3 viewPosition;
in vec3 worldPosition;


void main() {
    // TODO:
    // HINT: compute the following - light direction, ambient + diffuse + specular component,
    // then set the final color as a combination of these components
    // normalize vectors
    vec3 N = normalize(interpolatedNormal);                // surface normal
    vec3 L = normalize(spherePosition - worldPosition);    // light direction
    vec3 V = normalize(-viewPosition);                     // view direction (camera at origin)
    vec3 H = normalize(L + V);                             // halfway vector

    // compute lighting terms
    vec3 ambient  = kAmbient  * ambientColor;
    vec3 diffuse  = kDiffuse  * max(dot(N, L), 0.0) * diffuseColor;
    vec3 specular = kSpecular * pow(max(dot(N, H), 0.0), shininess) * specularColor;

    // final color
    gl_FragColor = vec4(ambient + diffuse + specular, 1.0);
}
