
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

    // this is all just a translation of the equation 
    // I = (Ka * Ia) + (Kd * Il * max(0, N · L)) + (Ks * Il * max(0, N · H)^Ns)
    // into code

    // "https://garykeen27.wixsite.com/portfolio/blinn-phong-shading" was used to assist in understanding

        
    vec3 lightDir = normalize(spherePosition - worldPosition);   
    vec3 viewDir = normalize(-viewPosition);                     
    vec3 halfwayVector = normalize(lightDir + viewDir);                             

    vec3 ambient  = kAmbient  * ambientColor;
    vec3 diffuse  = kDiffuse  * max(dot(interpolatedNormal, lightDir), 0.0) * diffuseColor;
    vec3 specular = kSpecular * pow(max(dot(interpolatedNormal, halfwayVector), 0.0), shininess) * specularColor;

    // final color
    gl_FragColor = vec4(ambient + diffuse + specular, 1.0);
}
