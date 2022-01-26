<template>
    <div id="three" ref="threeElement">
    </div>
</template>

<script>
import * as THREE from "three-full";
import { ParallaxBarrierEffect } from 'three-full';


export default {
  components: {},
  data() {
    return {
      container: undefined,
      scene: undefined,
      textureCube: undefined,
      camera: undefined,
      renderer: undefined,
      effect: undefined,
      sizeX: undefined,
      sizeY: undefined,
      mouseX: undefined,
      mouseY: undefined,
      spheres: undefined,
      orbitControls: undefined,
    };
  },
  mounted() {
    this.setup();
    this.$refs.threeElement.appendChild(this.renderer.domElement);
  },
  methods: {
    setup() {
      this.textureBack();

      
      // Assign Variables
      this.spheres =  [];
      this.sizeX = window.innerHeight/2;
      this.sizeY = window.innerHeight/2;
      this.mouseX = 0;
      this.mouseY = 0;

      // WindowListener
      document.addEventListener('mousemove', this.onDocumentMouseMove)

      // Setup Scene
      this.container = document.getElementById( 'three' );
      this.scene = new THREE.Scene();
      // this.scene.background = this.textureCube

      // Camera Settings
      this.camera = new THREE.PerspectiveCamera(
        75,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      this.camera.position.z = 3;

      // Renderer Settings
      this.renderer = new THREE.WebGLRenderer({ alpha: true });
      // this.renderer.setClearColor(new THREE.Color(0x151515));
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      this.renderer.setPixelRatio(window.devicePixelRatio)
      // this.renderer.shadowMap.enabled = true;
      // this.renderer.shadowMapSoft = true;
      // this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;

      // Load additional Functions
      this.addSpheres()
      this.addLights();
      this.effectA()
      this.render();
      this.onWindowResize();
      this.animate();
    },
    textureBack(){
      const loader = new THREE.CubeTextureLoader();
      loader.setPath('C:/Users/DELL/Desktop/CODE/L03/assets/textures/cube/pisaHDR/')
      // const path = '';


      this.textureCube = loader.load([
        'negx.jpg',
        'posx.jpg',
        'negy.jpg',
        'posy.jpg',
        'negz.jpg',
        'posz.jpg',
      ]);
      console.log('Texture: ');
      console.log(this.textureCube);
    },
    addSpheres(){
      const sizeA = Math.random()*Math.PI * 0.05
      const sizeB = Math.random()/Math.PI * 0.25
      const sizeC = Math.random()/Math.PI * 0.75
      const geometry = new THREE.BoxGeometry( sizeA,sizeB,sizeC );
      const material1 = new THREE.MeshStandardMaterial( { color: "cyan", } );
      const material2 = new THREE.MeshStandardMaterial( { color: "yellow", } );
      const material3 = new THREE.MeshStandardMaterial( { color: "magenta", } );

      for(let i=0; i < 10; i++){
        const mesh = new THREE.Mesh(geometry, material1);

        mesh.position.x = Math.random() * 10 - 5;
        mesh.position.y = Math.random() * 10 - 5;
        mesh.position.z = Math.random() * 10 - 5;

        mesh.scale.x = mesh.scale.y = mesh.scale.z = Math.random() * 3 + 1;

        this.scene.add(mesh)
        this.spheres.push( mesh )

      }
      for(let i=0; i < 10; i++){
        const mesh = new THREE.Mesh(geometry, material2);

        mesh.position.x = Math.random() * 10 - 5;
        mesh.position.y = Math.random() * 10 - 5;
        mesh.position.z = Math.random() * 10 - 5;

        mesh.scale.x = mesh.scale.y = mesh.scale.z = Math.random() * 2 + 1;

        this.scene.add(mesh)
        this.spheres.push( mesh )

      }
      for(let i=0; i < 10; i++){
        const mesh = new THREE.Mesh(geometry, material3);

        mesh.position.x = Math.random() * 10 - 5;
        mesh.position.y = Math.random() * 10 - 5;
        mesh.position.z = Math.random() * 10 - 5;

        mesh.scale.x = mesh.scale.y = mesh.scale.z = Math.random() * 5 + 1;

        this.scene.add(mesh)
        this.spheres.push( mesh )

      }

    },
    effectA(){
      const width = window.innerWidth || 2;
      const height = window.innerHeight || 2;
      this.effect = new ParallaxBarrierEffect( this.renderer );
      this.effect.setSize(width, height)
      window.addEventListener( 'resize', this.onWindowResize );

    },
    onWindowResize(){
      this.camera.aspect = window.innerWidth / window.innerHeight;
      this.camera.updateProjectionMatrix();

      this.effect.setSize( window.innerWidth, window.innerHeight );

    },
    onDocumentMouseMove( event ) {

				this.mouseX = ( event.clientX - this.sizeX ) / 100;
				this.mouseY = ( event.clientY - this.sizeY ) / 100;

    },
    addLights(){
      this.light1 = new THREE.PointLight(0xffffff, 1)
      this.light1.position.set(10,50,-200)
      this.light2 = new THREE.PointLight(0x3500ff, 1)
      this.light2.position.set(-600,-250,100)
      this.scene.add(this.light1, this.light2)

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

				this.render();
      },
      render(){
        const timer = 0.0001 * Date.now();
        this.camera.position.x += ( this.mouseX - this.camera.position.x ) * .05;
        this.camera.position.y += ( - this.mouseY - this.camera.position.y ) * .05;
        this.camera.lookAt( this.scene.position );

        for ( let i = 0, il = this.spheres.length; i < il; i ++ ) {

					const sphere = this.spheres[ i ];

					sphere.position.x = 5 * Math.cos( timer + i );
					sphere.position.y = 5 * Math.sin( timer + i * 1.1 );

				}
        this.effect.render( this.scene, this.camera );
        this.renderer.render( this.scene, this.camera );

        
      },

  },
    

  };
</script>

<style>

</style>