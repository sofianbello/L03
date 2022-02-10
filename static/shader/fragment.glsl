uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D image;
varying vec2 vUv;
void main(){
    vec2 st = gl_FragCoord.xy / resolution;
    vec4 texture = texture2D(image, vUv);
    float effect = abs(sin(texture.x + time));
    gl_FragColor = vec4(vec3(texture),1.0);
}