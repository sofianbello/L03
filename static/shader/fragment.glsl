#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 resolution;
uniform vec2 u_resolution;
uniform float time;
uniform vec2 mouse;
uniform sampler2D image;
varying vec2 vUv;

float circleShape(vec2 position, float radius){
    return step(radius, length(position - vec2(0.5)));
}

void main(){
    vec2 coord = 12.0 * gl_FragCoord.xy / resolution;

    for (int n = 1; n < 8 ; n++){
      float i = float(n); 
      coord += vec2(0.7 / i * sin(i * coord.y + time*0.5 + 0.3 * i) + 0.8*cos(mouse.x), 0.4 / i * sin( i* coord.x + time*0.5 + 0.3 * i)+ 1.6*cos(mouse.y));
       
    }

    // coord += vec2(0.7 / sin(coord.y + time + 0.3) + 0.8, 0.4 / sin(coord.x + time + 0.3)+ 1.6);
    vec3 color = vec3( 0.5 * sin( coord.x ) + 0.5, 0.5 * sin( coord.y ) + 0.5, 0.5 * sin( coord.x + coord.y ) + 0.5 );

    vec4 texture = texture2D(image, vUv);
    

    
    gl_FragColor = vec4(color, 1.0);
}