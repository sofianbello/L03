uniform vec2 resolution;
void main(){
    vec2 st = gl_FragCoord.xy / resolution;
    gl_FragColor = vec4(1.0,st.x,st.y,1.0);
}