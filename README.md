# Assignment 4
 
See [A4.pdf](A4.pdf) for the assignment specifications.

## Controls 
- WASD to move the light ball around on the xz plane
- QE to move the light ball up and down
- Click and drag to move camera
- 1,2,3,4 to switch shaders


Part 1a:

This was simple enough to do since all it really entailed was taking the Blinn-Phong equation and translating it into code. I drew up the differences between Phong and BP on a whiteboard just to help myself understand it better

![alt text](photos/PhongVsBlinnPhong.JPEG)

But this was not strictly necessary. (Apologies for the french, I'm using my notes as a way to practice)

The fragment shader just needed to make sure the normals are facing the right way and that the pixels of the model are being worked with in world space instead of local. 

"""
    // we take each vertex and 1) put it in terms of world coordinates instead of local to the dragon,
    // 2) get the normal and put it into world coordinates as well, and
    // 3) pass the view position along in world space so we can do math on it in the fragment
    worldPosition = vec3(modelMatrix * vec4(position, 1.0));
    interpolatedNormal = normalize(mat3(modelMatrix) * normal); // 3x3 to avoid translation and scaling, we only want the model matrix to rotate the normal to face the correct direction
    viewPosition = worldPosition;
"""

The vertex shader was more or less a 1:1 translation of math to code wrt Blinn-Phong. Look at the equation and make sure everything is accounted for and ordered correctly in the code so as to accurately represent the equation, of course normalizing our vectors

"""
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

"""

As a sidenote I went into A4.js and played with the color values slightly to more accurately match the colors in the assignment instructions, as the provided code came out very blue 

![alt text](photos/BeforeColorCorrection.png)
![alt text](photos/Part1aComplete.png)
