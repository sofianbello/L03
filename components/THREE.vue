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
      camera: undefined,
      geometry: undefined,
      material: undefined,
      mesh: undefined,
      light1: undefined,
      light2: undefined,
      renderer: undefined,
      sizeX: undefined,
      sizeY: undefined,
      orbitControls: undefined,
    };
  },
  mounted() {
    this.setup();
    this.$refs.threeElement.appendChild(this.renderer.domElement);
  },
  methods: {
    setup() {
      // set up scene, camera, renderer, and axes
      this.container = document.getElementById( 'three' );
      this.scene = new THREE.Scene();
      this.camera = new THREE.PerspectiveCamera(
        45,
        window.innerWidth / window.innerHeight,
        0.1,
        1000
      );
      this.camera.position.z = 3;
      this.renderer = new THREE.WebGLRenderer();
      this.renderer.setClearColor(new THREE.Color(0x000000));
      this.renderer.setSize(window.innerWidth, window.innerHeight);
      // this.renderer.shadowMap.enabled = true;
      // this.renderer.shadowMapSoft = true;
      // this.renderer.shadowMap.type = THREE.PCFSoftShadowMap;

      // WindowListener
      window.addEventListener( 'resize', this.onWindowResize );
      document.addEventListener('mousemove', this.onDocumentMouseMove)

      this.addSphere()
      this.addLights()
      this.render()
      this.onWindowResize()
    },
    addSphere(){
      
      this.geometry = new THREE.SphereGeometry( 3, 32, 16 );
      this.material = new THREE.MeshStandardMaterial( { color: 0x00ffff } );

      this.mesh = new THREE.Mesh( this.geometry, this.material );
      this.mesh.position.x =  1;
      this.mesh.position.y =  1 ;
      this.mesh.position.z =  - 10;

      this.scene.add( this.mesh );

    },
    addLights(){
      this.light1 = new THREE.PointLight(0xff0000, 20)
      this.light1.position.set(10,1,-1)
      this.scene.add(this.light1)

    },
    render(){
      this.renderer.render( this.scene, this.camera );
      
    },
    onWindowResize() {
      
      this.sizeX = window.innerWidth/2
			this.sizeY = window.innerHeight/2

			this.camera.aspect = window.innerWidth / window.innerHeight;
			this.camera.updateProjectionMatrix();

			this.renderer.setSize( window.innerWidth, window.innerHeight );
      this.render()

			},

  },
    

  };
</script>

<style>

</style>