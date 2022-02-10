uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D image;
void main(){
    vec2 st = gl_FragCoord.xy / resolution;
    vec4 texture = texture2D(image, st);
    float effect = abs(sin(texture.x + time));
    gl_FragColor = vec4(vec3(effect),1.0);
}