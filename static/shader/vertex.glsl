uniform vec2 resolution;
void main(){
    gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 0.5);
}