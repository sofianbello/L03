<template>
    <div id="three" ref="threeElement">
    </div>
</template>

<script>
import * as THREE from "three-full";
import { GLTFLoader } from 'three-full';
import GUI from 'lil-gui';


export default {
  components: {},
  data() {
    return {
      // Set  "this." Variables
      // Strictly necessary
      container: undefined,
      scene: undefined,
      textureCube: undefined,
      camera: undefined,
      renderer: undefined,

      // (Optional just for quality of life)
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
      // Assign Variables
      this.sizeX = window.innerHeight/2;
      this.sizeY = window.innerHeight/2;
      this.mouseX = 0;
      this.mouseY = 0;

      // WindowListener
      document.addEventListener('mousemove', this.onDocumentMouseMove)

      // Setup Scene
      this.container = document.getElementById( 'three' );
      this.scene = new THREE.Scene();

      // Setup Debug Ui
      this.debug = new GUI()
      this.debug.add(document, 'title')

      // Camera Settings
      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      this.camera.position.z = -40;

      // Renderer Settings
      this.renderer = new THREE.WebGLRenderer({alpha: true}); // For Transperancy add: { alpha: true }
      // this.renderer.setClearColor(new THREE.Color(0x151515)); // Set Canvas BG-Color
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setPixelRatio(window.devicePixelRatio)
      // this.renderer.shadowMap.enabled = true;
      // this.renderer.shadowMapSoft = true;
      // this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;

      // Load additional Functions
      this.objects();
      this.lights();
      this.render();
      this.animate();
    },

    objects(){
      this.loader = new THREE.TextureLoader()
      const geometry = new THREE.BoxGeometry(30,30,30);
      const heightMap = this.loader.load('./custom/height2.jpg');
      const normalTx = this.loader.load('./custom/NormalMap.png');
      const material = new THREE.MeshStandardMaterial({
        color: 0x00ff00,
        metalness: 0.7,
        roughness: 0.2,
        normalMap: normalTx,
        })
      // const texture = this.loader.load()

      this.mesh = new THREE.Mesh(geometry,material)
      this.scene.add(this.mesh)

    },
    lights(){
      this.light1 = new THREE.PointLight(0xffffff, 50.1)
      this.light1.position.set(200,3,40)
      this.light2 = new THREE.PointLight(0xff0000, 20)
      this.light2.position.set(100,1,50)
      this.scene.add(this.light1, this.light2)
      this.debug.add(this.light1.position, 'x', 50)
      this.debug.add(this.light1.position, 'y', 50)
      this.debug.add(this.light1.position, 'z', 50)
      this.debug.add(this.light2.position, 'x', 50)
      this.debug.add(this.light2.position, 'y', 50)
      this.debug.add(this.light2.position, 'z', 50)

    },
    onDocumentMouseMove( event ) {

				this.mouseX = ( event.clientX - this.sizeX ) / 100;
				this.mouseY = ( event.clientY - this.sizeY ) / 100;

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
        const timer = 0.0001 * Date.now();
        this.mesh.rotation.x = 5 * Math.cos( timer );
        this.mesh.rotation.y = 5 * Math.sin( timer * 1.1 );
        this.camera.position.x += ( this.mouseX - this.camera.position.x ) * .05;
        this.camera.position.y += ( - this.mouseY - this.camera.position.y ) * .05;
        this.camera.lookAt( this.scene.position );
				this.render();
      },
      render(){


        this.renderer.render( this.scene, this.camera );
        window.addEventListener( 'resize', this.onWindowResize );
        
      },

  },
    

  };
</script>

<style>

</style>