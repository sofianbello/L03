uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
void main(){
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 0.5);
}