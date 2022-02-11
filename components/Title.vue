<template>
  <div class="title-wrapper">
      <div >
        <h1 class="title">PURPLE HAZE</h1>
        <p class="description">
          We exist to vanquish design mediocracy and prepare brands for upcoming new trends in a ever evolving space.
          We offer independent and creative solutionsfor every need, get in touch to get amazing.
        </p>
      </div>
    </div>
</template>

<script>
export default {
    name: 'Title',

}
</script>

<style lang="scss" scoped>
.title-wrapper {
    position: relative;
    z-index: 1;
    margin: 0;
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    .title {
      padding: 2vw;
      width: 100%;
      max-width: 1400px;
      font-size: 16rem;
      line-height: 80%;
    //   margin: 0 2vw;
    }
    .description {
    //   display: block;  
      position: absolute; 
      bottom: 0;
    //   left: 60vw; 
      width: 500px;
      font-weight: 400;
      font-size: 2rem;
      text-transform: uppercase;
      color: hsl(0, 0%, 100%);
      margin-bottom: 5vh;
      margin-left: 65vw;
      @media (min-width: 750px) {
        font-size: 2rem;
    }
    }
    
    }
    h1 {
      color: rgb(255, 0, 234);
      font-size: 5rem;
      font-weight: 800;
      margin-bottom: 8px;
      @media (min-width: 750px) {
        font-size: 12rem;
      }
      
      span {
        font-weight: 200;
      }
    }
  
</style>