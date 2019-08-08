This is a height blended material shader for Unity. It was built with Amplify Shader Editor, so if you own a copy of Amplify Shader Editor, you can make any changes you want.

USAGE:

1. This shader supports up to 4 materials.

2. The material layers are ordered from bottom to top, so the textures for your first (bottom) material go in the "M4" slots. The textures for your second material go in the "M3" slots. Etc.

3. You will need to create a pack map for each of your materials. The pack map must have AO in the green channel, Height in the red channel, and Roughness in the blue channel.

4. Unity uses smoothness maps which are just inverted roughness maps. In case you’ve got traditional roughness maps and don’t want to go to the trouble of inverting them, I’ve added an “Invert Roughness” toggle to the shader which is on by default. (see screenshot below)

For more info about this shader:

https://medium.com/@JasonTuttle/want-a-height-blended-material-shader-for-unity-here-ya-go-231e2aeb6ccc

