<template>
<!-- 
  components: { THREE },Main Content Wraper -->
  <div class="home">
    <!-- <button @click.prevent="startScene">Start</button> -->
    <THREE class="threejs"/>
    <Hero />
    <WorkA />
    <WorkB />

    
  </div>
</template>




<style lang="scss" scoped>
.threejs{
  position: relative;
  z-index: 1;
}
</style>
