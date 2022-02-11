<template>
    <div id="three" ref="threeElement">
    </div>
</template>

<script>
import * as THREE from "three-full";
import GUI from 'lil-gui';
import vertex from '../static/shader/vertex.glsl'
import fragment from '../static/shader/fragment.glsl'


export default {
  components: {},
  data() {
    return {

      /** 
       * Set  "this." Variables
       * Strictly necessary
      */
      container: undefined,
      scene: undefined,
      textureCube: undefined,
      camera: undefined,
      renderer: undefined,
      uniforms: undefined,

      /** 
       * Optional just for quality of life
      */

      debug: undefined,
      mesh: undefined,
      sizeX: undefined,
      sizeY: undefined,
      mouseX: undefined,
      mouseY: undefined,
      loader: undefined,
      orbitControls: undefined,
    };
  },
  mounted() {      //Initial Function (Will be executed immeadiatly on page load)
    this.setup(); // Setup Environment
    this.$refs.threeElement.appendChild(this.renderer.domElement);
  },
  methods: {
    setup() {
      /** 
       * Assign Variables
      */

      this.sizeX = window.innerWidth/2;
      this.sizeY = window.innerHeight/2;
      this.mouseX = 0;
      this.mouseY = 0;

      /**
       * Event Listeners
      */

      document.addEventListener('mousemove', this.onDocumentMouseMove)

      /** 
       * Scene
      */ 

      this.container = document.getElementById( 'three' );
      this.scene = new THREE.Scene();

      /**
       * Debug
       */

      this.debug = new GUI()
      this.debug.open(true)

      /**
       * Camera
       */

      this.camera = new THREE.PerspectiveCamera(
        45,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      this.camera.position.z = 100;
      const cameraGUI = this.debug.addFolder('Camera')
      cameraGUI.add(this.camera.position, 'z').name('Position Z')
      /**
       * Renderer
       */

      this.renderer = new THREE.WebGLRenderer({alpha: true}); // For Transperancy add: { alpha: true }
      // this.renderer.setClearColor(new THREE.Color(0x151515)); // Set Canvas BG-Color
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setPixelRatio(window.devicePixelRatio)
      // this.renderer.shadowMap.enabled = true;
      // this.renderer.shadowMapSoft = true;
      // this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;

      /**
       * Generate Objects
       */

      this.objects();
    },

    objects(){
      this.loader = new THREE.TextureLoader()
      
      const geoSize = { x: this.sizeX, y: this.sizeX, z: 10}
      const imgTx = this.loader.load('./textures/grass/grasslight-big.jpg');
      const normalTx = this.loader.load('./textures/grass/grasslight-big-nm.jpg');
      const heightMap = this.loader.load('./custom/height2.jpg');
      
      this.uniforms = {
        time: { type: 'f', value: 0.0},
        mouse: {type: 'v2', value: new THREE.Vector2(0.0, 0.0)},
        resolution: {type: 'v2', value: new THREE.Vector2(window.innerWidth, window.innerHeight)
                        .multiplyScalar(window.devicePixelRatio)},
        image: {type: 't', value: imgTx},

      }
//    #1 
      const geometry = new THREE.BoxBufferGeometry(geoSize.x*0.5,geoSize.y*0.5, geoSize.z*0.15)
      // const geometry = new THREE.PlaneGeometry(geoSize.x*0.25,geoSize.y*0.25)
      const materialM = new THREE.MeshStandardMaterial({
        color: 0xff00ff,
      })
      const materialC = new THREE.MeshStandardMaterial({
        color: 0xffff00,
      })

      
      const shader = new THREE.ShaderMaterial({
        uniforms: this.uniforms,
        vertexShader: vertex,
        fragmentShader: fragment,
        wireframe: false,
        })

      window.addEventListener('mousemove', function(e) {
        shader.uniforms.mouse.value.set(e.screenX / window.innerWidth, 1 - e.screenY / window.innerHeight)
      })

      const yellow = new THREE.Mesh(geometry,materialC)
      const magenta = new THREE.Mesh(geometry,materialM)

      this.mesh = new THREE.Mesh(geometry,shader)
      this.mesh.position.x = 1
      this.mesh.position.y = 1
      this.mesh.position.z = -150
      this.mesh.rotation.x = 0
      this.mesh.rotation.z = 0

      yellow.position.x += this.mesh.position.x+1;
      yellow.position.y += this.mesh.position.y+4;
      yellow.position.z += this.mesh.position.z-3;
      magenta.position.x += this.mesh.position.x-2;
      magenta.position.y += this.mesh.position.y-2;
      magenta.position.z += this.mesh.position.z-2;
      yellow.rotation.z += this.mesh.rotation.z;
      magenta.rotation.z += this.mesh.rotation.z+0.01;
      const object1 = this.debug.addFolder('Object 1')
      object1.add(this.mesh.position, 'x').name('Position X')
      object1.add(this.mesh.position, 'y').name('Position Y')
      object1.add(this.mesh.position, 'z').name('Position Z')
      object1.add(this.mesh.rotation, 'x').name('Rotation X').step('0.01').min(-Math.PI).max(Math.PI)
      object1.add(this.mesh.rotation, 'y').name('Rotation Y').step('0.01').min(-Math.PI).max(Math.PI)
      object1.add(this.mesh.rotation, 'z').name('Rotation Z').step('0.01').min(-Math.PI).max(Math.PI)
      object1.open(true)
      this.scene.add(this.mesh)
      // this.scene.add(yellow, magenta)
      this.lights()

    },
    lights(){
      this.light1 = new THREE.PointLight(0xffffff, -1)
      this.light1.position.set(200,3,0)
      this.light2 = new THREE.PointLight(0xa2744e, 15)
      this.light2.position.set(100,1,150)
      this.scene.add(this.light1, this.light2)
      const debugLight1 = this.debug.addFolder('Light 1')
      const debugLight2 = this.debug.addFolder('Light 2')
      debugLight1.add(this.light1.position, 'x').name('Position X')
      debugLight1.add(this.light1.position, 'y').name('Position Y')
      debugLight1.add(this.light1.position, 'z').name('Position Z')
      debugLight1.add(this.light1, 'intensity').name('Intensity')
      debugLight1.addColor(this.light1, 'color').name('Color')
      debugLight1.open(false)
      debugLight2.add(this.light2.position, 'x').name('Position X')
      debugLight2.add(this.light2.position, 'y').name('Position Y')
      debugLight2.add(this.light2.position, 'z').name('Position Z')
      debugLight2.add(this.light2, 'intensity').name('Intensity')
      debugLight2.addColor(this.light2, 'color').name('Color')
      debugLight2.open(false)

      this.animate()
    },
    onDocumentMouseMove( event ) {
      
      this.mouseX = ( event.clientX - this.sizeX ) / 100;
				this.mouseY = 1 - ( event.clientY - this.sizeY ) / 100;

    },
    onWindowResize() {
      
      this.sizeX = window.innerWidth/2
			this.sizeY = window.innerHeight/2

			this.camera.aspect = window.innerWidth / window.innerHeight;
			this.camera.updateProjectionMatrix();

			this.renderer.setSize( window.innerWidth, window.innerHeight );
      this.render()

			},
      animate(){
        requestAnimationFrame( this.animate );
        const clock = new THREE.Clock()
        clock.running = true;
        this.uniforms.time.value = clock.getElapsedTime();
        // const timer = 0.0001 * Date.now();
        // this.mesh.rotation.x = 5 * Math.cos( timer );
        // this.mesh.rotation.y = 5 * Math.sin( timer * 1.1 );
        // this.camera.position.x += ( this.mouseX - this.camera.position.x ) * .05;
        // this.camera.position.y += ( - this.mouseY - this.camera.position.y ) * .05;
        this.camera.lookAt( this.scene.position );
				this.render();      },
      render(){


        this.renderer.render( this.scene, this.camera );
        window.addEventListener( 'resize', this.onWindowResize );
        
      },

  },
    

  };
</script>

<style>

</style>