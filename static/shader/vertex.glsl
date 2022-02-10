uniform vec2 resolution;
uniform float time;
uniform vec2 mouse;
varying vec2 vUv;
void main(){
    vUv = uv;
    gl_Position = projectionMatrix * modelViewMatrix * vec4(max((position.x*.3),sin(time)*.5)*3.,max(6. *(position.y*2.),cos(time)),position.z, .9);
}